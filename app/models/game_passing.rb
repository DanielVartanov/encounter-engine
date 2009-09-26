class GamePassing < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :current_level, :class_name => "Level"

  def check_answer!(answer)
    correct = (answer == current_level.correct_answers)
    if correct
      self.current_level = self.current_level.next
      save!
    end
    correct
  end
end