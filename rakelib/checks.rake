# Build checks, loaded automatically by rake from rakelib/.
# `check_urls` stays in the Rakefile with its html-proofer configuration.

# --- Upgrade safety nets -------------------------------------------------
#
# html-proofer checks the links in what was built; it cannot notice that a page
# was not built at all, which is how a govuk_tech_docs or middleman upgrade
# usually breaks a site.

# The nav ordering and the review banner are built from these.
REQUIRED_FRONTMATTER = %w[title last_reviewed_on review_in weight].freeze

desc "Check every page has the frontmatter the nav and review banner need"
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

desc "Check the expected pages were built (run after middleman build)"
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
