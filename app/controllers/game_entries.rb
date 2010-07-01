class GameEntries < Application
  before :ensure_authenticated
  before :find_game, :only=>:new
  before :find_team, :only=>:new
  before :find_entry, :exclude =>:new

  def new
    @game_entry = GameEntry.all(:conditions =>
        {:team_id => @team.id, :game_id => @game.id}).first
    @game_entry = GameEntry.new unless @game_entry
    @game_entry.status = "new"
    @game_entry.game = @game
    @game_entry.team_id = @team.id
    @game_entry.save
    redirect url(:dashboard)
  end
  
  def accept
    @entry.status = "accepted"
    @entry.save
    redirect url(:dashboard)
  end
  
  def reject
    @entry.status = "rejected"
    @entry.save
    redirect url(:dashboard)
  end

protected
  def find_game
    @game = Game.find(params[:game_id])
  end  
  
  def find_team
    @team = Team.find(params[:team_id])
  end
  def find_entry
    @entry=GameEntry.find(params[:id])
  end
end