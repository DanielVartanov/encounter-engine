# -*- encoding : utf-8 -*-
class NotificationMailer < Merb::MailController

  def welcome_letter
    @email = params[:email]
    @password = params[:password]
    render_mail
  end

  def invitation_notification
    @team = params[:team]
    render_mail
  end

  def reject_notification
    @user = params[:user]
    render_mail
  end

  def accept_notification
    @user = params[:user]
    render_mail
  end
  
end
