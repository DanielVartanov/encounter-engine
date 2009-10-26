class Hints < Application  
  before :find_level
  before :find_game
  before :build_hint

  before :ensure_author

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
end