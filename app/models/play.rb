# frozen_string_literal: true

class Play < ApplicationRecord
  belongs_to :game
  belongs_to :team
  belongs_to :current_level, class_name: 'Level'

  has_many :answer_attempts, dependent: :restrict_with_exception

  before_validation :start_with_first_level
  before_save :update_reached_current_level_at, if: -> { current_level_id_changed? }

  def advance_current_level!
    update current_level: next_level
  end

  def next_level
    game.levels[game.levels.find_index(current_level) + 1]
  end

  def currently_available_hints
    current_level.hints.order(:delay_in_minutes).select do |hint|
      Time.current >= self.reached_current_level_at + hint.delay_in_minutes.minutes
    end
  end

  private

  def start_with_first_level
    self.current_level ||= game.levels.first
  end

  def update_reached_current_level_at
    self.reached_current_level_at = Time.current
  end
end
