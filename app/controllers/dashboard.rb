class Dashboard < Application
  before :ensure_authenticated
  before :find_invitations_for_current_user
  before :find_team

  def index
    #debugger
    render
  end

protected

  def find_invitations_for_current_user
    @invitations = Invitation.for @current_user
  end

  def find_team
    if @current_user.captain?
      @team = Team.find(@current_user.team.id)
    else
      @team = nil
    end
  end
end
