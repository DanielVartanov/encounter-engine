class Logs < Application
  before :ensure_authenticated
  before :find_game
  before :ensure_author

  def index
    render
  end

  def show_live_channel
    render
  end

  def find_game
    @game = Game.find(params[:game_id])
  end  

end