# A sample Gemfile
source :gemcutter

merb_gems_version = "1.1.3"

gem "merb-core", merb_gems_version
#gem "merb-action-args", merb_gems_version
gem "merb-assets", merb_gems_version
gem "merb-helpers", merb_gems_version
gem "merb-mailer", merb_gems_version
gem "merb-slices", merb_gems_version
gem "merb-param-protection", merb_gems_version
gem "merb-exceptions", merb_gems_version

merb_auth_gems_version = "1.1.0"
gem "merb-auth-core", merb_auth_gems_version
gem "merb-auth-more", merb_auth_gems_version
gem "merb-auth-slice-password", merb_auth_gems_version

gem "merb_activerecord"
gem "activerecord", "2.3.8"
gem "acts-as-list", "0.1.2", :require => 'acts_as_list'

gem "mongrel"
gem "sqlite3-ruby", "1.2.5"

group :development do
  gem 'ruby-debug'
  gem "linecache", "=0.43"
  gem 'rspec', '1.3.0', :require => 'spec'
end

group :test do
  gem 'gherkin', '2.1.4'
  gem 'cucumber', '0.8.5'
  gem 'cucumber-rails', '0.3.2'
  gem 'launchy'
  gem 'merb_cucumber', '0.6.1'
  gem 'webrat', '0.7.1'
  gem 'nokogiri', '1.4.1'
  gem 'rspec', '1.3.0', :require => 'spec'
end
