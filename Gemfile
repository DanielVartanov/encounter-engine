source 'https://rubygems.org'

ruby '2.2.3'

merb_gems_version = '1.1.3'

gem 'merb-core', merb_gems_version
#gem 'merb-action-args', merb_gems_version
gem 'merb-assets', merb_gems_version
gem 'merb-helpers', path: '~/src/merb/merb-helpers'
gem 'merb-mailer', merb_gems_version
gem 'merb-slices', merb_gems_version
gem 'merb-param-protection', merb_gems_version
gem 'merb-exceptions', merb_gems_version

gem 'merb-auth-core', path: '~/src/merb-auth/merb-auth-core'
gem 'merb-auth-more', path: '~/src/merb-auth/merb-auth-more'
gem 'merb-auth-slice-password', path: '~/src/merb-auth/merb-auth-slice-password'

gem 'merb_activerecord', path: '~/src/merb_activerecord'
gem 'activerecord', '~> 4.1.0'
gem 'acts_as_list'
gem 'thin'
gem 'sqlite3'
gem 'unicode_utils'

group :development do
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec', '1.3.0', :require => 'spec'
end

group :test do
  gem 'cucumber', '0.10.6'
  gem 'cucumber-rails', '0.3.2'
  gem 'launchy'
  gem 'merb_cucumber', '0.6.1'
  gem 'webrat'
  gem 'nokogiri', '1.5.11'
end
