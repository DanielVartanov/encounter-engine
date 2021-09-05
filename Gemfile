# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'webpacker', '~> 5.0'
gem 'turbo-rails'
gem 'jbuilder'
gem 'redis'
gem 'bootsnap', require: false
gem 'haml-rails'
gem 'bootstrap'
gem 'bootstrap_form', git: 'https://github.com/bootstrap-ruby/bootstrap_form.git', branch: 'bootstrap-5'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'puts_debuggerer'
  gem 'parallel_tests'
  gem 'launchy'
  gem 'ruby_jard'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false
  gem 'haml_lint', require: false
end

group :development do
  gem 'web-console'
  gem 'rack-mini-profiler'
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rexml'
  gem 'rspec-its'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'super_diff'
end
