# frozen_string_literal: true

class Hint < ApplicationRecord
  belongs_to :level, inverse_of: :hints

  def available_for?(play)
    return false if self.level != play.current_level

    play.reached_current_level_at <= self.delay_in_minutes.minutes.ago
  end
end
