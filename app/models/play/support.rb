# frozen_string_literal: true

class Play
  module Support
    def reset!
      self.current_level = game.levels.first
      self.finished_at = nil
      self.reached_current_level_at = nil
      save!
    end
  end
end
