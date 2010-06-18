class Dashboard < Application
  before :ensure_authenticated
  before :find_invitations_for_current_user
  before :find_team
  before :find_request

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
      puts "Captain!!!"
      @team = Team.find(@current_user.team.id)
    else
      @team = nil
    end
  end

  def find_request
    if @current_user.captain?
      @request = Request.all(:conditions => ["team", @current_user.team.id])
    else
      @request = nil
    end
  end
end
