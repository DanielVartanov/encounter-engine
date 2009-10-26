class Levels < Application
  before :find_game
  before :ensure_author
  before :ensure_game_was_not_started, :only => [:create, :update]  
  before :build_level, :only => [:create, :new]
  before :find_level, :exclude => [:create, :new]

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

  def edit
    render
  end

  def update
    if @level.update_attributes(params[:level])
      redirect resource(@level.game, @level)
    else
      render :edit
    end
  end

  def move_up
    @level.move_higher
    redirect resource(@game)
  end

  def move_down
    @level.move_lower
    redirect resource(@game)
  end

protected
  
  def find_game
    @game = Game.find(params[:game_id])
  end

  def build_level
    @level = Level.new(params[:level])    
    @level.game = @game
  end

  def find_level
    @level = Level.find(params[:id])
  end
  
  def ensure_game_was_not_started
    raise Unauthorized, "Нельзя редактировать игру после её начала" if @game.started?
  end
end