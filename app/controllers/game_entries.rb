class GameEntries < Application
  before :ensure_authenticated
  before :find_game
  before :find_team

  def new
    debugger
    
  end

protected
  def find_game
    @game = Game.find(params[:game_id])
  end  
  
  def find_team
    @team = Team.find(params[:team_id])
  end
end