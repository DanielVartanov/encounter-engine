class GamePassing < Application
  before :find_game
  before :ensure_authenticated  
  before :ensure_team_member
  before :ensure_game_is_started
  before :ensure_not_author_of_the_game

  def index
    @current_level = @game.levels.first
    render
  end

protected

  def find_game
    @game = Game.find params[:game_id]
  end

  def ensure_game_is_started
    raise Unauthorized, "Нельзя играть в игру до её начала. И вообще, где вы достали эту ссылку? :-)" unless  @game.started?
  end

  def ensure_not_author_of_the_game
    raise Unauthorized, "Нельзя играть в собственные игры, сорри :-)" if @game.created_by?(current_user)
  end
end