class Games < Application
  before :ensure_authenticated, :exclude => [:index, :show]
  before :build_game, :only => [:new, :create]
  before :find_game, :only => [:show, :edit, :update, :delete, :end_game]
  before :find_team, :only => [:show]
  before :ensure_author_if_game_is_draft, :only => [:show]
  before :ensure_author_if_no_start_time,:only =>[:show]
  before :ensure_author, :only => [:edit, :update]
  before :ensure_game_was_not_started, :only => [:edit, :update]

  def index
    unless params[:user_id].blank?
      user = User.find(params[:user_id])
      @games = user.created_games
    else
      @games = Game.non_drafts
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
    @game_entries = GameEntry.of_game(@game).with_status("new")
    @teams = []
    GameEntry.of_game(@game).with_status("accepted").each do |entry|
      @teams << Team.find(entry.team_id)
    end
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

  def delete
    @game.destroy
    redirect url(:dashboard)
  end

  def end_game
    @game.finish_game!
    game_passings = GamePassing.of_game(@game)
    game_passings.each do |gp|
      gp.end!
    end
    redirect url(:dashboard)
  end

protected

  def build_game
    @game = Game.new(params[:game])
    @game.author = @current_user
  end

  def find_game    
    @game = Game.find(params[:id])
  end  

  def game_is_draft?
    @game.draft?
  end

  def find_team
    if @current_user
      @team = @current_user.team
    else
      @team = nil
    end
  end

  def no_start_time?
    @game.starts_at.nil?
  end
  def ensure_author_if_game_is_draft
    ensure_author if game_is_draft?
  end
  def ensure_author_if_no_start_time
    ensure_author if no_start_time?
  end
end