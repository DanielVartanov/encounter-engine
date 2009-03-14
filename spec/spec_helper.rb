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

module MailerHelper
  def assert_sends_email(&block)    
    block.should change(Merb::Mailer.deliveries, :size).by(1)
  end
end

module FixtureHelper
  def create_user
    random_nickname = "valid" + rand(100000).to_s
    random_email = random_nickname + "@diesel.kg"
    
    User.create! :nickname => random_nickname, :email => random_email, :password => "1234",
      :password_confirmation => "1234"
  end

  def create_team(options={})
    random_name = "Team#" + rand(100000).to_s
    team = Team.new(:name => random_name, :captain => options[:captain])
    team.members << options[:members] unless options[:members].nil?
    team.save!
    team
  end

  def create_invitation(options={})
    for_user = options[:for] || create_user
    from_team = options[:from] || create_team(:captain => create_user)
    Invitation.create! :to_team => from_team, :recepient_nickname => for_user.nickname
  end

  def build_game(options={})
    creation_params = {
      :author => create_user,
      :name => rand(10000).to_s,
      :description => rand(10000).to_s,
      :starts_at => "2099-01-01 00:00"
    }.merge(options)
    Game.new creation_params
  end

  def create_game(options={})
    biuld_game(options).save!
  end
end

module ExceptionsHelper
  def assert_unauthenticated(&block)
    block.should raise_error(Merb::Controller::Unauthenticated)
  end

  def assert_unauthorized(&block)
    block.should raise_error(Merb::Controller::Unauthorized)
  end
end

include MailerHelper
include FixtureHelper
include ExceptionsHelper

require Merb.root / "spec" / 'mail_controller_spec_helper'
include MailControllerTestHelper

include ActiveRecordHelper
ActiveRecordHelper::ActiveRecordHelper.recreate_database!