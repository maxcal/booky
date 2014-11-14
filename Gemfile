source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails', '4.1.6'
gem 'unicorn', '~> 4.8.3' # Use unicorn as the app server
gem 'dotenv-rails', '~> 1.0.2' # Loads environment variables from `.env` file.

# == DB ==========================================================
gem 'pg', '~> 0.17.1' # postgres

# == Assets ======================================================
gem 'sass-rails', '~> 4.0.3' # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'jquery-rails' # Use jquery as the JavaScript library

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# == Security ====================================================


group :development do
  gem 'annotate', '~> 2.6.5'
  gem 'guard-livereload', require: false # reloads browser when files are changed
  gem 'better_errors' # better error pages
  gem 'binding_of_caller' # REPL on error pages
  gem 'meta_request' # used for RailsPanel in Google Chrome
  gem 'guard-yard' # automatically run and update your local YARD Documentation Server
end

group :development, :test do
  # gem 'debugger', group: [:development, :test] # Use debugger
  gem 'rspec-rails', '~> 3.1.0'
  gem 'guard-rspec', '~> 4.3.1' # Guard::RSpec automatically run your specs (much like autotest).
  gem 'zeus', '~> 0.15.3'   # Boot any rails app in under a second
  gem 'database_cleaner', '~> 1.3.0'# Strategies for cleaning databases. Can be used to ensure a clean state for testing.
  gem 'capybara', '~> 2.4.4' # Capybara is an integration testing tool for rack based web applications.
  gem "terminal-notifier-guard", "~> 1.5.3", require: false # Show test status indicators on Mac OS X
  gem 'simplecov', require: false # Used to generate test coverage reports
end

group :production do
  # Run Rails the 12factor way
  gem 'rails_12factor', '~> 0.0.3'
end