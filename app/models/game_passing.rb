class GamePassing < ActiveRecord::Base
  serialize :answered_questions
  default_value_for :answered_questions, []

  belongs_to :team
  belongs_to :game
  belongs_to :current_level, :class_name => "Level"

  named_scope :of_game, lambda { |game| { :conditions => { :game_id => game.id } } }
  named_scope :of_team, lambda { |team| { :conditions => { :team_id => team.id } } }
  named_scope :ended_by_author, :conditions => ['status = "ended"'], :order => 'current_level_id DESC'
  named_scope :exited, :conditions => ['status = "exited"'], :order => 'finished_at DESC'
  named_scope :finished, :conditions => ['finished_at IS NOT NULL'], :order => 'finished_at ASC'
  named_scope :finished_before, lambda { |time| { :conditions => ['finished_at < ?', time] } }

  before_create :update_current_level_entered_at

  def self.of(team, game)
    self.of_team(team).of_game(game).first
  end

  def check_answer!(answer)
    answer.strip!

    if correct_answer?(answer)
      answered_question = current_level.find_question_by_answer(answer)
      pass_question!(answered_question)
      pass_level! if all_questions_answered? or question_is_gold?
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
    if last_level?
      set_finish_time
    else
      update_current_level_entered_at
    end

    reset_answered_questions

    self.current_level = self.current_level.next
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
    unanswered_questions.any? { |question| question.matches_any_answer(answer) }
  end

  def time_at_level
    difference = Time.now - self.current_level_entered_at
    hours, minutes, seconds = seconds_fraction_to_time(difference)
    "%02d:%02d:%02d" % [hours, minutes, seconds]
  end

  def unanswered_questions
    current_level.questions - answered_questions
  end

  def all_questions_answered?
    if current_level.has_gold_question?
      (current_level.questions - self.answered_questions - [current_level.gold_question]).empty?
    else
      (current_level.questions - self.answered_questions).empty?
    end
  end

  def question_is_gold?
    self.answered_questions.last.gold
  end

  def exit!
    self.finished_at = Time.now
    self.status = "exited"
    self.save!
  end

  def exited?
    self.status == "exited"
  end

  def end!
    if !self.exited?
      self.status = "ended"
      self.save!
    end
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

  def reset_answered_questions
    self.answered_questions.clear
  end

  # TODO: keep SRP, extract this to a separate helper
  def seconds_fraction_to_time(seconds)
    hours = minutes = 0
    if seconds >= 60 then
      minutes = (seconds / 60).to_i
      seconds = (seconds % 60).to_i

      if minutes >= 60 then
        hours = (minutes / 60).to_i
        minutes = (minutes % 60).to_i
      end
    end
    [hours, minutes, seconds]
  end

end
