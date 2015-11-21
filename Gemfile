source 'https://rubygems.org'

ruby '2.2.3'

merb_gems_version = '1.1.3'
gem 'merb-core', path: 'vendor/merb/merb-core'
gem 'merb-helpers', path: 'vendor/merb/merb-helpers'
gem 'merb-slices', path: 'vendor/merb/merb-slices'
gem 'merb-assets', merb_gems_version
gem 'merb-mailer', merb_gems_version
gem 'merb-param-protection', merb_gems_version
gem 'merb-exceptions', merb_gems_version

gem 'merb-auth-core', path: 'vendor/merb-auth/merb-auth-core'
gem 'merb-auth-more', path: 'vendor/merb-auth/merb-auth-more'
gem 'merb-auth-slice-password', path: 'vendor/merb-auth/merb-auth-slice-password'

gem 'merb_activerecord', git: 'https://github.com/DanielVartanov/merb_activerecord.git', branch: 'modernize'
gem 'activerecord', '~> 4.2.5'
gem 'acts_as_list'
gem 'thin'
gem 'unicode_utils'

gem 'rspec', '1.3.0', :require => 'spec'

group :development do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-byebug'
end

group :test do
  gem 'cucumber', '0.10.6'
  gem 'cucumber-rails', '0.3.2'
  gem 'launchy'
  gem 'merb_cucumber', '0.6.1'
  gem 'webrat'
  gem 'nokogiri', '1.5.11'
end

group :production do
  gem 'pg'
end
