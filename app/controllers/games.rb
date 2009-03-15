class Games < Application
  before :ensure_authenticated, :only => [:new, :create]
  before :build_game, :only => [:new, :create]
  before :find_game, :only => [:show]
  before :ensure_author_if_draft, :only => [:show]

  def index
    unless params[:user_id].blank?
      user = User.find(params[:user_id])
      @games = user.created_games
    else
      @games = Game.all :conditions => { :is_draft => false }
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

  def ensure_author_if_draft
    if @game.draft?
      unless logged_in? and @current_user.author_of?(@game)
        raise Unauthorized, "Эта игра пока в черновиках, только её автор может войти в профиль"
      end
    end
  end
end