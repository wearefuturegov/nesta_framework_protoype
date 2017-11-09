source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

# UI
# gem 'draper'
gem 'haml-rails'
gem 'jquery-rails'
gem 'sass-rails'

# gem 'geff', git: 'https://github.com/wearefuturegov/geff.git'
if ENV['GEFF_DEV']
  gem 'geff', path: '../geff'
else
  gem 'geff', github: 'wearefuturegov/geff'
end

gem 'web_address_validator', git: 'https://github.com/wearefuturegov/web_address_validator.git'

gem 'uglifier', '>= 1.3.0'

# DB
gem 'pg'

gem 'puma'
gem 'aasm'
gem 'country_select'
gem 'email_validator'
gem 'chartkick'
gem 'cocoon'
gem 'que'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'coveralls', require: false
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'turnip'
  gem 'capybara-selenium'
  gem 'chromedriver-helper'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
