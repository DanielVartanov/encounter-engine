# -*- encoding : utf-8 -*-
class Hint < ActiveRecord::Base
  belongs_to :level

  def delay_in_minutes
    self.delay.nil? ? nil : self.delay / 60
  end

  def delay_in_minutes=(value)
    self.delay = value.to_i * 60
  end

  def ready_to_show?(current_level_entered_at)
    seconds_passed = Time.now - current_level_entered_at
    seconds_passed >= self.delay
  end

  def available_in(current_level_entered_at)
    (current_level_entered_at - Time.now).to_i + self.delay
  end
end
