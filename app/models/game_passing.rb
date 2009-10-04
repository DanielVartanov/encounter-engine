class GamePassing < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :current_level, :class_name => "Level"

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