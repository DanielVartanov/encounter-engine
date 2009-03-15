class Games < Application
  before :ensure_authenticated, :only => [:new, :create]
  before :build_game, :only => [:new, :create]
  before :find_game, :only => [:show, :edit, :update]
  before :ensure_author_if_game_is_draft, :only => [:show]
  before :ensure_author, :only => [:edit, :update]

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

  def edit
    render
  end

  def update    
    if @game.update_attributes(params[:game])
      redirect resource(@game)
    else
      render :edit
    end
  end

protected

  def build_game
    @game = Game.new(params[:game])
    @game.author = @current_user
  end

  def find_game    
    @game = Game.find(params[:id])
  end

  def ensure_author    
    unless logged_in? and @current_user.author_of?(@game)
      raise Unauthorized, "Эта игра пока в черновиках, только её автор может войти в профиль"
    end
  end

  def game_is_draft?
    @game.draft?
  end

  def ensure_author_if_game_is_draft
    ensure_author if game_is_draft?
  end
end