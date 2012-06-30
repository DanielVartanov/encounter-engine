class Answers < Application
  before :find_game
  before :ensure_author
  before :find_level
  before :find_question
  before :find_answers
  before :find_answer, :only => [:delete]
  before :build_answer, :only => [:index, :create]

  def index
    render
  end

  def create
    if @answer.save
      redirect resource(@game, @level, @question, :answers)
    else
      render :index
    end
  end

  def delete
    if @answers.count > 1
      @answer.destroy
      redirect resource(@game, @level, @question, :answers)
    else
      build_answer
      @answer.errors.add(:question, "Должен быть хотя бы один вариант кода")
      render :index
    end
  end

protected

  def find_game
    @game = Game.find(params[:game_id])
  end

  def find_level
    @level = Level.find(params[:level_id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_answers
    @answers = Answer.of_question(@question)
  end

  def build_answer
    @answer = Answer.new(params[:answer])
    @answer.level = @level
    @answer.question = @question
  end
end