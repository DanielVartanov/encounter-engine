class GamePassing < ActiveRecord::Base
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

  def check_answer!(answer)    
    if correct_answer?(answer)
      self.finished_at = Time.now if last_level?
      self.current_level = self.current_level.next
      update_current_level_entered_at
      save!
      true
    else
      false
    end    
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
    answer.strip == current_level.correct_answers
  end

protected

  def last_level?
    self.current_level.next.nil?
  end

  def update_current_level_entered_at
    self.current_level_entered_at = Time.now
  end
end