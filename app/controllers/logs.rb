class Logs < Application
  before :ensure_authenticated
  before :find_game
  before :ensure_author, :only => [:show_live_channel, :show_level_log, :show_game_log]
  before :find_team, :only => [:show_level_log, :show_game_log]
  before :find_level, :only => [:show_level_log, :show_game_log]

  def index
    render
  end

  def show_live_channel
    @logs =Log.of_game(@game)
    render
  end

  def show_level_log
    @logs = Log.of_game(@game).of_team(@team).of_level(@level)
    render
  end

  def show_game_log
    @logs = Log.of_game(@game).of_team(@team)
    render
  end

  def show_full_log
    @logs =Log.of_game(@game)
    @levels = Level.of_game(@game)
    @teams = Team.find_by_sql("select * from teams t inner join game_passings gp on t.id = gp.team_id where gp.game_id = #{@game.id}")
    render
  end

protected

  def find_game
    @game = Game.find(params[:game_id])
  end  
  
  def find_team
    @team = Team.find(params[:team_id])
  end

  def find_level
    @level = @team.current_level_in(@game)
  end

end