# frozen_string_literal: true

class Play
  module Support
    def reset!
      self.current_level = game.levels.first
      self.reached_current_level_at = Time.current
      self.finished_at = nil
      ActiveRecord::Base.transaction do
        save!
        reevaluate_available_hints!
      end
    end
  end
end
