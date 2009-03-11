class Games < Application
  before :ensure_authenticated, :only => [:new, :create]
  before :build_game, :only => [:new, :create]
  before :find_game, :only => [:show]

  def index
    unless params[:user_id].blank?
      user = User.find(params[:user_id])
      @games = user.created_games
    else
      @games = Game.all
    end
    render
  end

  def new
    render
  end

  def create
    if @game.save
      redirect resource(@game)
    else
      render :new
    end
  end

  def show
    render
  end

protected

  def build_game
    @game = Game.new(params[:game])
    @game.author = @current_user
  end

  def find_game
    @game = Game.find(params[:id])
  end
end