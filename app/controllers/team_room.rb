class TeamRoom < Application
  before :ensure_authenticated
  before :ensure_team_member

  def index  
    render
  end
end
