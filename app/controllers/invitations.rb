class Invitations < Application
  before :ensure_authenticated

  before :build_invitation, :only => [:new, :create]
  before :ensure_team_captain, :only => [:new, :create]

  before :find_invitation, :only => [:reject, :accept]
  before :ensure_recepient, :only => [:reject, :accept]

  def new
    only_provides :html        
    render
  end

  def create    
    if @invitation.save
      send_invitation_notification(@invitation)
      redirect resource(:invitations, :new), :message => "Пользователю #{@invitation.recepient_email} выслано приглашение"
    else
      render :new
    end
  end

  def accept
    add_user_to_team_members

    @invitation.delete

    send_accept_notification(@invitation)

    reject_rest_of_invitations    

    redirect url(:dashboard)
  end

  def reject    
    @invitation.delete
    send_reject_notification(@invitation)
    redirect url(:dashboard)
  end

protected

  def build_invitation
    @invitation = Invitation.new(params[:invitation])
    @invitation.to_team = @current_user.team
  end

  def send_invitation_notification(invitation)
    send_mail NotificationMailer, :invitation_notification,
      { :to => invitation.for_user.email,
        :from => "noreply@bien.kg",
        :subject => "Вас пригласили вступить в команду #{invitation.to_team.name}" },
      { :team_name => invitation.to_team.name }
  end

  def send_reject_notification(invitation)
    send_mail NotificationMailer, :reject_notification,
      { :to => invitation.to_team.captain.email,
        :from => "noreply@bien.kg",
        :subject => "Пользователь #{invitation.for_user.email} отказался от приглашения" },
      { :user_email => invitation.for_user.email }
  end

  def send_accept_notification(invitation)
    send_mail NotificationMailer, :accept_notification,
      { :to => invitation.to_team.captain.email,
        :from => "noreply@bien.kg",
        :subject => "Пользователь #{invitation.for_user.email} принял Ваше приглашение" },
      { :user_email => invitation.for_user.email }
  end

  def add_user_to_team_members
    team = @invitation.to_team
    team.members << @current_user
  end
  
  def reject_rest_of_invitations
    Invitation.for(@current_user).each do |invitation|
      invitation.delete
      send_reject_notification(invitation)
    end
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