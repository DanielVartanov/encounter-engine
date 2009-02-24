class NotificationMailer < Merb::MailController

  def welcome_letter
    @email = params[:email]
    @password = params[:password]
    render_mail
  end

  def invitation_notification
    @team_name = params[:team_name]
    render_mail
  end
  
end
