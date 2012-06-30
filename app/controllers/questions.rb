class Questions < Application
  before :find_game
  before :ensure_author
  before :find_level
  before :build_question, :only => [:new, :create]
  before :find_question, :only => [:delete]

  def new
    render
  end

  def create
    @question.correct_answer = params[:question][:correct_answer]
    @question.gold = params[:question][:gold]

    if @question.save
      @answer = @question.answers.first
      if @answer.save
        redirect resource(@level.game, @level)
      else
        @question.destroy
        build_question
        render :new
      end
    else
      render :new
    end
  end

  def delete
    @question.destroy
    redirect resource(@level.game, @level)
  end

  protected

  def find_game
    @game = Game.find(params[:game_id])
  end

  def find_level
    @level = Level.find(params[:level_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def build_question
    @question = Question.new(params[:question])
    @question.level = @level
  end
end