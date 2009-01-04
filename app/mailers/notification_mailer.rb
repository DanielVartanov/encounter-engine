class NotificationMailer < Merb::MailController

  def welcome_letter
    @email = params[:email]
    @password = params[:password]
    render_mail
  end
  
end
