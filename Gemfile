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
gem 'rufus-scheduler'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'puts_debuggerer'
  gem 'parallel_tests'
  gem 'launchy'
  gem 'ruby_jard'
  gem 'haml_lint', require: false

  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false
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
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'super_diff'
  gem 'timecop'

  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-mocks'
end
