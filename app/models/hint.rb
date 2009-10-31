class Hint < ActiveRecord::Base
  belongs_to :level

  def delay_in_minutes
    self.delay / 60
  end

  def delay_in_minutes=(value)
    self.delay = value * 60
  end

  def ready_to_show?(current_level_entered_at)
    seconds_passed = Time.now - current_level_entered_at    
    seconds_passed >= self.delay
  end
end