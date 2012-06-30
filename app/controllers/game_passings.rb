class GamePassings < Application
  include GamePassingsHelper

  before :find_game, :exclude => [:exit_game]
  before :find_game_by_id, :only => [:exit_game]
  before :find_team, :exclude => [:show_results, :index]
  before :find_or_create_game_passing, :exclude => [:show_results, :index]
  before :ensure_authenticated, :exclude => [:index, :show_results]
  before :ensure_game_is_started
  before :ensure_team_captain, :only => [:exit_game]
  before :ensure_not_finished, :exclude => [:index, :show_results]
  before :author_finished_at, :exclude => [:index, :show_results]
  before :ensure_team_member, :exclude => [:index, :show_results]
  before :ensure_not_author_of_the_game, :exclude => [:index, :show_results]
  before :ensure_author, :only => [:index]
  before :get_uniq_level_codes, :only => [:show_current_level]

  provides :json

  def show_current_level
    render :layout => 'in_game'
  end

  def index
    @game_passings = GamePassing.of_game(@game)
    render
  end

  def get_current_level_tip
    next_hint = @game_passing.upcoming_hints.first; # next_hint  ?

    { :hint_num => @game_passing.hints_to_show.length,
      :hint_text => @game_passing.hints_to_show.last.text,
      :next_available_in => next_hint.nil? ? nil : next_hint.available_in(@game_passing.current_level_entered_at) }.to_json
  end

  def post_answer
    unless @game_passing.finished?
     @answer = params[:answer].strip
      save_log
      @answer_was_correct = @game_passing.check_answer!(@answer)
      unless @game_passing.finished?
        get_uniq_level_codes
        render :show_current_level, :layout => 'in_game'
      else
        render :show_results
      end
    else
      render :show_results
    end
  end

  def save_log
    if @game_passing.current_level.id
      @level = Level.find(@game_passing.current_level.id)
      Log.create! :game_id => @game.id,
                  :level => @level.name,
                  :team => @team.name,
                  :time => Time.now,
                  :answer => @answer
    end
  end

  def show_results
    render
  end

  def exit_game
    @game_passing.exit!
    render :show_results
  end

protected

  def find_game
    @game = Game.find params[:game_id]
  end

  def find_game_by_id
    @game = Game.find(params[:id])
  end

  # TODO: must be a critical section, double creation is possible!
  def find_or_create_game_passing
    @game_passing = GamePassing.of(@team,@game)

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
    raise Unauthorized, "Нельзя играть в игру до её начала. И вообще, где вы достали эту ссылку? :-)" unless @game.started? unless @game.is_testing?
  end

  def ensure_not_author_of_the_game
    raise Unauthorized, "Нельзя играть в собственные игры, сорри :-)" if @game.created_by?(current_user) unless @game.is_testing?
  end

  def author_finished_at
    raise Unauthorized, "Игра была завершена автором, и вы не можете в нее больше играть" if @game.author_finished?
  end

  def ensure_captain_exited
    raise Unauthorized, "Команда сошла с дистанции" if @game_passing.exited?
  end

  def ensure_not_finished
    self.author_finished_at
    self.ensure_captain_exited
  end

  def get_uniq_level_codes
    correct_answers = []
    log_of_level = Log.of_game(@game).of_level(@game_passing.current_level).of_team(current_user.team)
    entered_answers = log_of_level.map { |u| u.answer }.uniq

    @game_passing.current_level.questions.each do |question|
      question.answers.each do |answer|
        correct_answers << answer.value
      end
    end
    @entered_correct_answers = entered_answers & correct_answers
  end
end
