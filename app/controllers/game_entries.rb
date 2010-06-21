class GameEntries < Application
  before :ensure_authenticated
  before :find_game
  before :find_team

  def new
    @game_entry = GameEntry.all(:conditions => { :team_id => @team.id, :game_id => @game.id }).first
    if !@game_entry
      @game_entry = GameEntry.new
    end
    @game_entry.status = "new"
    @game_entry.game = @game
    @game_entry.team_id = @team.id
    @game_entry.save
    redirect url(:dashboard)
  end

protected
  def find_game
    @game = Game.find(params[:game_id])
  end  
  
  def find_team
    @team = Team.find(params[:team_id])
  end
end