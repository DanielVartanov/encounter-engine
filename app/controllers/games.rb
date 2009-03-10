class Games < Application
  before :ensure_authenticated
  before :build_game

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

protected

  def build_game
    @game = Game.new(params[:game])
  end
end