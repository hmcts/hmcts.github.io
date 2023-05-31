# If you do not have OpenSSL installed, change
# the following line to use 'http://'
source 'https://rubygems.org'

# For faster file watcher updates on Windows:
gem 'wdm', '~> 0.1.0', platforms: [:mswin, :mingw]

# Windows does not come with time zone data
gem 'tzinfo-data', platforms: [:mswin, :mingw, :jruby]

# Include the tech docs gem
gem 'govuk_tech_docs'

# HAML 6 isn't currently working with middleman
# ruby/3.2.2/lib/ruby/gems/3.2.0/gems/middleman-syntax-3.2.0/lib/middleman-syntax/haml_monkey_patch.rb:4:in `<module:Haml>': Filters is not a module (TypeError)
# ruby/3.2.2/lib/ruby/gems/3.2.0/gems/haml-6.1.1/lib/haml/filters/base.rb:5: previous definition of Filters was here
gem 'haml', '~> 6.0', '>= 6.1.1'

gem 'middleman-gh-pages'
