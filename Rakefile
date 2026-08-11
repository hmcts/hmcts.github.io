require 'middleman-gh-pages'
require 'html-proofer'

task :check_urls do
    proofer = HTMLProofer.check_directory("./build",
        {
            :check_external_hash => false,
            :ignore_missing_alt => true,
            :ignore_status_codes => [0, 401, 403, 429],
            :ignore_urls =>  [
                # Ignore pulls/branches as these do not translate to raw content
                %r{github\.com/hmcts/(?=.*(?:pull|tree|commit))},
                # This is a url that's generated each time we build the html by tech-docs-gem but does not exist
                %r{https://github.com/hmcts/hmcts.github.io/blob/main/source/search/index.html},
                # This handles new files that haven't been merged to master branch yet for this repo in a PR
                %r{(?=.*hmcts.github.io)(?=.*github)},
                # Private repos return 404 to unauthenticated requests when the URL contains an anchor (#)
                # as the rewrite to raw.githubusercontent.com is skipped for anchor URLs
                %r{https://github.com/hmcts/azure-platform-terraform}
            ]
        })

    token = ENV.fetch('GH_TOKEN', nil)
    proofer.before_request do |request|
        if request.base_url.include?("https://github.com/hmcts/")
            request.options[:headers]["Authorization"] = "Bearer #{token}"
            base_url_parts = request.base_url.split('/')
            # 5 parts is if we're just querying a repo itself - which needs a generic file added to the URl
            # to check the repo exists
            if base_url_parts.length == 5 && !request.base_url.include?('#')
                request.base_url = request.base_url.gsub("github.com", "raw.githubusercontent.com")
                # This repo builds from source branch
                request.base_url += request.base_url.include?("hmcts.github.io") ? "/main/README.md" : "/master/README.md"
            # Checking for blob is to convert URLs pointing to files
            elsif request.base_url.include?("/blob/")
                request.base_url = request.base_url.gsub("/blob", "")
                request.base_url = request.base_url.gsub("github.com", "raw.githubusercontent.com")
            end
        end
    end
    # Run HTML Proofer against built HTML files
    proofer.run
end
# --- Upgrade safety nets -------------------------------------------------
#
# html-proofer checks the links in what was built; it cannot notice that a page
# was not built at all, which is how a govuk_tech_docs or middleman upgrade
# usually breaks a site.

# The nav ordering and the review banner are built from these.
REQUIRED_FRONTMATTER = %w[title last_reviewed_on review_in weight].freeze

task :check_frontmatter do
  require 'yaml'
  problems = []
  pages = Dir.glob('source/**/*.html.md.erb').sort
  pages.each do |path|
    text = File.read(path)
    unless text.start_with?("---\n")
      problems << "#{path}: no frontmatter block"
      next
    end
    front = text.split("---\n")[1].to_s
    begin
      data = YAML.safe_load(front, permitted_classes: [Date, Time]) || {}
    rescue StandardError => e
      problems << "#{path}: frontmatter will not parse (#{e.class})"
      next
    end
    missing = REQUIRED_FRONTMATTER.reject { |k| data.key?(k) }
    problems << "#{path}: missing #{missing.join(', ')}" unless missing.empty?
  end
  puts "checked frontmatter on #{pages.length} pages"
  abort "\n#{problems.length} page(s) with frontmatter problems:\n  " + problems.join("\n  ") unless problems.empty?
end

# An explicit list beats a count for the pages that matter: if an upgrade stops
# rendering a section, this names it. Add to the list when adding a section
# somebody would notice the loss of.
CRITICAL_PAGES = %w[
  index.html
  cjs-common-platform/index.html
  cjs-common-platform/onboarding/index.html
  cloud-native-platform/index.html
  hmcts-overview/index.html
  standards/index.html
].freeze

# A floor rather than an exact figure, so adding pages needs no edit here while
# losing a swathe of them still fails. Measured at 109 built pages on 2026-08-11;
# set below that with a little headroom, so a few deliberate deletions do not nag
# but a section vanishing does. Raise it when the site grows materially.
MINIMUM_BUILT_PAGES = 100

task :check_pages do
  abort 'build/ is absent - run `bundle exec middleman build` first' unless Dir.exist?('build')

  missing = CRITICAL_PAGES.reject { |page| File.exist?(File.join('build', page)) }
  built = Dir.glob('build/**/*.html').length
  puts "built #{built} html pages; #{CRITICAL_PAGES.length - missing.length}/#{CRITICAL_PAGES.length} critical pages present"

  problems = []
  problems << "critical pages missing from the build: #{missing.join(', ')}" unless missing.empty?
  problems << "only #{built} pages built, below the floor of #{MINIMUM_BUILT_PAGES} - something stopped rendering" if built < MINIMUM_BUILT_PAGES
  abort "\n" + problems.join("\n") unless problems.empty?
end
