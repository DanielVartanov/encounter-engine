class GamePassing < ActiveRecord::Base
  serialize :answered_questions

  belongs_to :team
  belongs_to :game
  belongs_to :current_level, :class_name => "Level"

  named_scope :of_game, lambda { |game| { :conditions => { :game_id => game.id } } }
  named_scope :of_team, lambda { |team| { :conditions => { :team_id => team.id } } }
  named_scope :finished, :conditions => ['finished_at IS NOT NULL'], :order => 'finished_at ASC'
  named_scope :finished_before, lambda { |time| { :conditions => ['finished_at < ?', time] } }

  before_create :update_current_level_entered_at

  def self.of(team, game)
    self.of_team(team).of_game(game).first
  end

  # Spec that answered-questions is cleared in pass_level!
  # Specs for pass_level
  	# increase #passed_questions_count
  	# какой именно вопрос был отвечен -- это _похуй_, не надо это проверять
  # Specs for pass_question!

  # specs for GamePassings#post_answer + helper 
  	# #answer_was_correct?  def answer_was_correct?  whataver; end
  	# answer_posted?

  def check_answer!(answer)
    if correct_answer?(answer)
    	answered_question = current_level.questions.find_by_answer(answer)
    	pass_question!(answered_question)
    	pass_level! if all_questions_answered?
    	true
   	else
    	false
    end
  end

  def pass_question!(question)
		answered_questions << question
		save!
  end

  def pass_level!
    self.current_level = self.current_level.next
    set_finish_time if last_level?
    update_current_level_entered_at
    save!
  end

  def finished?
    !! finished_at
  end

  def hints_to_show
    current_level.hints.select { |hint| hint.ready_to_show?(current_level_entered_at) }
  end

  def upcoming_hints
    current_level.hints.select { |hint| !hint.ready_to_show?(current_level_entered_at) }
  end

  def correct_answer?(answer)
    unanswered_questions.any? { |question| answer.strip == question.answer }
  end

  def time_at_level
    difference = Time.now - self.current_level_entered_at
    hours, minutes, seconds = seconds_fraction_to_time(difference)
    "%02d:%02d:%02d" % [hours, minutes, seconds]
  end

  def unanswered_questions
		current_level.questions - answered_questions
	end

protected

  def last_level?
    self.current_level.next.nil?
  end

  def update_current_level_entered_at
    self.current_level_entered_at = Time.now
  end
  
  def set_finish_time
  	self.finished_at = Time.now
  end

  # TODO: keep SRP, extract this to a separate helper
  def seconds_fraction_to_time(seconds)
    hours = minutes = 0
    if seconds >=  60 then
      minutes = (seconds / 60).to_i
      seconds = (seconds % 60 ).to_i

      if minutes >= 60 then
        hours = (minutes / 60).to_i
        minutes = (minutes % 60).to_i
      end
    end
    [hours, minutes, seconds]
  end

end
