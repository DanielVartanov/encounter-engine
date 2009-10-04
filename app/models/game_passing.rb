class GamePassing < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :current_level, :class_name => "Level"

  named_scope :of_game, lambda { |game| { :conditions => { :game_id => game.id } } }
  named_scope :of_team, lambda { |team| { :conditions => { :team_id => team.id } } }
  named_scope :finished, :conditions => ['finished_at IS NOT NULL'], :order => 'finished_at ASC'
  named_scope :finished_before, lambda { |time| { :conditions => ['finished_at < ?', time] } }

  def self.of(team, game)
    self.of_team(team).of_game(game).first
  end

  def check_answer!(answer)    
    if correct_answer?(answer)
      self.finished_at = Time.now if last_level?
      self.current_level = self.current_level.next      
      save!
      true
    else
      false
    end    
  end

  def finished?
    !! finished_at
  end
  
protected

  def last_level?
    self.current_level.next.nil?
  end

  def correct_answer?(answer)
    answer == current_level.correct_answers
  end
end