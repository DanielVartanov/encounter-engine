class Logs < Application
  before :ensure_authenticated
  before :find_game
  before :ensure_author, :only => [:show_live_channel]
  # before :find_level, :only => [:level_log]
 # before :find_team, :only => [:level_log, :game_log]

  def index
    render
  end

  def show_live_channel
    @logs = Log.all :conditions => { :game_id => @game.id }
    render
  end

  def find_game
    @game = Game.find(params[:game_id])
  end  

end