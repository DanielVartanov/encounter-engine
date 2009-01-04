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

module MailControllerTestHelper  
  def clear_mail_deliveries
    Merb::Mailer.deliveries.clear
  end

  def last_delivered_mail
    Merb::Mailer.deliveries.last
  end
  
  def describe_mail(mailer, template, &block)
    describe "/#{mailer.to_s.downcase}/#{template}" do
      before :each do
        @mailer_class, @template = mailer, template
        @assigns = {}
        clear_mail_deliveries
      end

      def deliver(send_params={}, mail_params={})
        mail_params = {:from => "from@example.com", :to => "to@example.com", :subject => "Please activate your account"}.merge(mail_params)
        @mailer_class.new(send_params).dispatch_and_deliver @template.to_sym, mail_params
        @mail = Merb::Mailer.deliveries.last
      end

      instance_eval(&block)
    end
  end
end

include MailControllerTestHelper