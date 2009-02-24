class Invitations < Application
  before :ensure_authenticated
  before :ensure_team_captain

  before :build_invitation  

  def new
    only_provides :html        
    render
  end

  def create    
    if @invitation.save
      send_invitation_notification @invitation
      redirect resource(:invitations, :new), :message => "Пользователю #{@invitation.recepient_email} выслано приглашение"
    else
      render :new
    end
  end

protected

  def build_invitation
    @invitation = Invitation.new(params[:invitation])
    @invitation.from_team = @current_user.team
  end

  def send_invitation_notification(invitation)
    send_mail NotificationMailer, :invitation_notification,
      { :to => invitation.to_user.email,
        :from => "noreply@bien.kg",
        :subject => "Вас пригласили вступить в команду #{invitation.from_team.name}" },
      { :team_name => invitation.from_team.name }
  end
end