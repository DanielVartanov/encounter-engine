class Hint < ActiveRecord::Base
  belongs_to :level

  def ready_to_show?(current_level_entered_at)
    seconds_passed = Time.now - current_level_entered_at    
    seconds_passed >= self.delay
  end
end