class Hints < Application  
  before :find_level
  before :find_game
  before :build_hint, :only => [:new, :create]
  before :find_hint, :only => [:edit, :update]

  before :ensure_author
  before :ensure_game_was_not_started, :only => [:new, :create, :edit, :update]  

  def new
    render
  end

  def create
    if @hint.save
      redirect resource(@game, @level)
    else
      render :new
    end
  end

  def edit
    render
  end

  def update
    if @hint.update_attributes(params[:hint])
      redirect resource(@level.game, @level)
    else
      render :edit
    end
  end

protected

  def build_hint
    @hint = Hint.new(params[:hint])
    @hint.level = @level
  end

  def find_level
    @level = Level.find(params[:level_id])
  end

  def find_game
    @game = @level.game
  end

  def find_hint
    @hint = Hint.find(params[:id])
  end
end