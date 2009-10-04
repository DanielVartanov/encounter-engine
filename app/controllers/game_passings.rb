class GamePassings < Application
  before :find_game
  before :ensure_authenticated, :exclude => [:show_results]
  before :ensure_team_member, :exclude => [:show_results]
  before :ensure_game_is_started
  before :ensure_not_author_of_the_game, :exclude => [:show_results]
  before :find_team
  before :find_or_create_game_passing

  def show_current_level
    render
  end

  def pass_level
    @result = @game_passing.check_answer!(params[:answer])
    unless @game_passing.finished?
      render :show_current_level
    else
      render :show_results
    end
  end

  def show_results
    render
  end

protected

  def find_game
    @game = Game.find params[:game_id]
  end

  # TODO: must be a critical section, double creation is possible!
  def find_or_create_game_passing
    @game_passing = GamePassing.first :conditions => { :team_id => @team.id, :game_id => @game.id }

    if @game_passing.nil?
      @game_passing = GamePassing.create! :team => @team, 
        :game => @game,
        :current_level => @game.levels.first
    end
  end

  def find_team
    @team = current_user.team
  end

  def ensure_game_is_started
    raise Unauthorized, "Нельзя играть в игру до её начала. И вообще, где вы достали эту ссылку? :-)" unless @game.started?
  end

  def ensure_not_author_of_the_game
    raise Unauthorized, "Нельзя играть в собственные игры, сорри :-)" if @game.created_by?(current_user)
  end
end