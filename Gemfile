# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails'
gem 'sprockets-rails'
gem 'pg'
gem 'puma'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'
gem 'redis'
gem 'bootsnap', require: false
gem 'haml-rails'
gem 'sassc-rails'
gem 'bootstrap'
gem 'bootstrap_form'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'puts_debuggerer'
  gem 'ruby_jard'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false
  gem 'haml_lint', require: false
  gem 'parallel_tests'
end

group :development do
  gem 'web-console'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rspec-its'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'launchy'
  gem 'super_diff'
end
