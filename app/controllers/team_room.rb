class TeamRoom < Application
  before :ensure_authenticated
  before :ensure_team_member

  def index
    @team = @current_user.team
    render
  end
end
