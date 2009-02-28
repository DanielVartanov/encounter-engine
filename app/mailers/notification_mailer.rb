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

  def reject_notification
    @user_email = params[:user_email]
    render_mail
  end

  def accept_notification
    @user_email = params[:user_email]
    render_mail
  end
  
end
