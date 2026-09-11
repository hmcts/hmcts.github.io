# Refreshes data/terraform_modules.yml (rendered by
# source/platform-catalogue/terraform-modules/index.html.md.erb) from the
# .hmcts/catalogue.yaml file each Terraform module repo owns. Discovery is
# via the 'terraform-module' GitHub topic, not a hard-coded repo list, so
# newly tagged repos are picked up automatically.
#
# Deliberately standard-library-only (net/http, json, yaml) to match rakelib/checks.rake
# rather than adding a new gem for a handful of GitHub API calls.

require 'net/http'
require 'uri'
require 'json'
require 'yaml'

GITHUB_ORG = 'hmcts'.freeze
CATALOGUE_TOPIC = 'terraform-module'.freeze
CATALOGUE_DATA_FILE = 'data/terraform_modules.yml'.freeze
LOCAL_CATALOGUE_SOURCE = 'poc/terraform-modules'.freeze
REQUIRED_CATALOGUE_FIELDS = %w[apiVersion id name type category description owner lifecycle consumption version terraform providers repository links].freeze
ALLOWED_LIFECYCLES = %w[supported deprecated experimental].freeze

def github_get(uri_string)
  uri = URI(uri_string)
  request = Net::HTTP::Get.new(uri)
  request['User-Agent'] = 'hmcts-platform-catalogue'
  request['Accept'] = 'application/vnd.github+json'
  token = ENV.fetch('GH_TOKEN', nil)
  request['Authorization'] = "Bearer #{token}" if token
  Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
end

def discover_module_repos
  url = "https://api.github.com/search/repositories?q=org:#{GITHUB_ORG}+topic:#{CATALOGUE_TOPIC}&per_page=100"
  repos = []

  loop do
    response = github_get(url)
    unless response.is_a?(Net::HTTPSuccess)
      abort "could not list repos with topic '#{CATALOGUE_TOPIC}' (#{response.code}); catalogue data was not changed"
    end

    payload = JSON.parse(response.body)
    # GitHub's repository search API will return at most 1,000 results. Do not
    # publish a knowingly incomplete catalogue if the topic grows beyond that.
    if payload['total_count'].to_i > 1000
      abort "#{payload['total_count']} repos have topic '#{CATALOGUE_TOPIC}', above GitHub search's 1,000 result limit"
    end

    repos.concat(payload['items'] || [])
    next_link = response['link'].to_s.split(',').find { |link| link.include?('rel="next"') }
    break unless next_link

    url = next_link[/<([^>]+)>/, 1]
  end

  repos
end

def discover_local_module_repos
  abort "local catalogue source '#{LOCAL_CATALOGUE_SOURCE}' does not exist" unless Dir.exist?(LOCAL_CATALOGUE_SOURCE)

  Dir.children(LOCAL_CATALOGUE_SOURCE).sort.filter_map do |name|
    path = File.join(LOCAL_CATALOGUE_SOURCE, name)
    next unless Dir.exist?(path)

    { 'name' => name, 'default_branch' => 'main', 'local_path' => path }
  end
end

def fetch_catalogue_yaml(repo_name, default_branch, local_path: nil)
  if local_path
    path = File.join(local_path, '.hmcts', 'catalogue.yaml')
    return nil unless File.exist?(path)

    return YAML.safe_load_file(path, permitted_classes: [Date])
  end

  url = "https://raw.githubusercontent.com/#{GITHUB_ORG}/#{repo_name}/#{default_branch}/.hmcts/catalogue.yaml"
  response = github_get(url)
  return nil unless response.is_a?(Net::HTTPSuccess)

  YAML.safe_load(response.body, permitted_classes: [Date])
rescue StandardError => e
  puts "warning: #{repo_name} - .hmcts/catalogue.yaml did not parse (#{e.class}: #{e.message})"
  nil
end

def refresh_catalogue(repos, source:)
  puts "found #{repos.length} #{source} repo(s)"

  discovered = repos.filter_map do |repo|
    entry = fetch_catalogue_yaml(repo['name'], repo['default_branch'], local_path: repo['local_path'])
    unless entry
      puts "warning: #{repo['name']} - no .hmcts/catalogue.yaml on #{repo['default_branch']}, skipping"
      next nil
    end
    next nil unless validate_catalogue_entry(repo['name'], entry)

    entry.merge('repo' => repo['name'], 'default_branch' => repo['default_branch'])
  end

  final = discovered.sort_by { |e| e['name'].to_s }
  File.write(CATALOGUE_DATA_FILE, final.to_yaml)

  puts "published #{discovered.length} discovered entry(s), wrote #{final.length} total to #{CATALOGUE_DATA_FILE}"
end

def validate_catalogue_entry(repo_name, entry)
  problems = []
  problems << "missing #{(REQUIRED_CATALOGUE_FIELDS - entry.keys).join(', ')}" unless (REQUIRED_CATALOGUE_FIELDS - entry.keys).empty?
  if entry['lifecycle'] && !ALLOWED_LIFECYCLES.include?(entry['lifecycle'])
    problems << "lifecycle '#{entry['lifecycle']}' not one of #{ALLOWED_LIFECYCLES.join(', ')}"
  end
  if entry['lifecycle'] == 'deprecated' && entry['replacement'].to_s.empty?
    problems << 'lifecycle is deprecated but replacement is missing'
  end
  unless %w[self-service contribution-required].include?(entry.dig('consumption', 'model'))
    problems << 'consumption.model must be self-service or contribution-required'
  end
  problems << 'version.recommended is missing' if entry.dig('version', 'recommended').to_s.empty?
  problems << 'terraform.minimum_version is missing' if entry.dig('terraform', 'minimum_version').to_s.empty?
  if entry['repository'].is_a?(Hash)
    %w[url default_branch archived topics].each do |field|
      problems << "repository.#{field} is missing" if entry['repository'][field].nil? || entry['repository'][field] == ''
    end
  else
    problems << 'repository must be an object'
  end
  %w[documentation examples].each do |field|
    problems << "links.#{field} is missing" if entry.dig('links', field).to_s.empty?
  end
  return true if problems.empty?

  puts "warning: #{repo_name} - invalid .hmcts/catalogue.yaml (#{problems.join('; ')})"
  false
end

desc 'Refresh the Platform Catalogue Terraform modules data from GitHub'
task :'catalogue:refresh' do
  refresh_catalogue(discover_module_repos, source: "repo(s) tagged '#{CATALOGUE_TOPIC}'")
end

desc 'Refresh the Platform Catalogue from local POC Terraform module fixtures'
task :'catalogue:refresh_local' do
  refresh_catalogue(discover_local_module_repos, source: 'local POC')
end
