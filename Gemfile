# If you do not have OpenSSL installed, change
# the following line to use 'http://'
source 'https://rubygems.org'

# For faster file watcher updates on Windows:
gem 'wdm', '~> 0.1.0', platforms: [:mswin, :mingw]

# Windows does not come with time zone data
gem 'tzinfo-data', platforms: [:mswin, :mingw, :jruby]

# Include the tech docs gem
gem 'govuk_tech_docs'

gem 'middleman-gh-pages'
gem 'html-proofer'

gem 'mutex_m'
gem 'sprockets'
gem 'base64'

# Ruby 4.0 removed most of CGI from the default gems; rouge still calls CGI.parse.
# Same reason mutex_m, sprockets and base64 are listed above.
gem 'cgi'