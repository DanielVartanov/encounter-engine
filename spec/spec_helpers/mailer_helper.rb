module MailerHelper
  def assert_sends_email(&block)
    block.should change(Merb::Mailer.deliveries, :size).by(1)
  end

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