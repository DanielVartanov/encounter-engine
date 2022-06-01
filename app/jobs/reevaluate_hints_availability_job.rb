# frozen_string_literal: true

class ReevaluateHintsAvailabilityJob < ApplicationJob
  queue_as :default

  def perform(play)
    # Also see doc/reevaluate_available_hints_race_condition.markdown

    play.reevaluate_available_hints!
  end
end
