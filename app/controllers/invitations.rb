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
      redirect resource(:invitations, :new), :message => "Пользователю #{@invitation.recepient_email} выслано приглашение"
    else
      render :new
    end
  end

protected

  def build_invitation
    @invitation = Invitation.new(params[:invitation])
  end
end