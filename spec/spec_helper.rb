require "rubygems"

# Add the local gems dir if found within the app root; any dependencies loaded
# hereafter will try to load from the local gems before loading system gems.
if (local_gem_dir = File.join(File.dirname(__FILE__), '..', 'gems')) && $BUNDLE.nil?
  $BUNDLE = true; Gem.clear_paths; Gem.path.unshift(local_gem_dir)
end

require "merb-core"
require "spec" # Satisfies Autotest and anyone else not using the Rake tasks

# this loads all plugins required in your init file so don't add them
# here again, Merb will do it for you
Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
end

module FixtureHelpers
  def create_user(params={})
    default_params = { :email => "valid@email.com", :password => "1234",
          :password_confirmation => "1234" }
    User.create(default_params.merge(params))
  end

  def create_team(options={})
    Team.create(:name => "A Team", :captain => options[:captain])
  end
end

include FixtureHelpers

require Merb.root / "spec" / 'mail_controller_spec_helper'
include MailControllerTestHelper

include ActiveRecordHelper
ActiveRecordHelper::ActiveRecordHelper.recreate_database!