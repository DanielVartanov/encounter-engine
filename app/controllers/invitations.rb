class Invitations < Application
  before :ensure_authenticated

  before :build_invitation, :only => [:new, :create]
  before :ensure_team_captain, :only => [:new, :create]

  before :find_invitation, :only => [:reject]
  before :ensure_recepient, :only => [:reject] 

  def new
    only_provides :html        
    render
  end

  def create    
    if @invitation.save
      send_invitation_notification
      redirect resource(:invitations, :new), :message => "Пользователю #{@invitation.recepient_email} выслано приглашение"
    else
      render :new
    end
  end

  def reject
    Invitation.delete @invitation.id
    send_reject_notification
    redirect url(:dashboard)
  end

protected

  def build_invitation
    @invitation = Invitation.new(params[:invitation])
    @invitation.to_team = @current_user.team
  end

  def send_invitation_notification
    send_mail NotificationMailer, :invitation_notification,
      { :to => @invitation.for_user.email,
        :from => "noreply@bien.kg",
        :subject => "Вас пригласили вступить в команду #{@invitation.to_team.name}" },
      { :team_name => @invitation.to_team.name }
  end

  def send_reject_notification    
    send_mail NotificationMailer, :reject_notification,
      { :to => @invitation.to_team.captain.email,
        :from => "noreply@bien.kg",
        :subject => "Пользователь #{@invitation.for_user.email} отказался от приглашения" },
      { :user_email => @invitation.for_user.email }    
  end

  def find_invitation    
    @invitation = Invitation.find params[:id]
  end

  def ensure_recepient
    unless @current_user.id == @invitation.for_user.id
      raise Unauthorized, "Вы должны быть получателем приглашения чтобы выполнить это действие"
    end
  end
end