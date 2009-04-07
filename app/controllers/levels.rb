class Levels < Application
  before :find_game
  before :build_level, :only => [:create, :new]
  before :find_level, :only => [:show]
  before :ensure_author

  def new
    render
  end

  def create
    if @level.save
      redirect resource(@game, @level)
    else
      render :new
    end
  end

  def show
    render
  end

protected

  def find_game
    @game = Game.find(params[:game_id])
  end

  def build_level
    @level = Level.new(params[:level])
    @level.order = 1
    @level.game = @game
  end

  def find_level
    @level = Level.find(params[:id])
  end
end