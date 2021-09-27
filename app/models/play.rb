# frozen_string_literal: true

class Play < ApplicationRecord
  belongs_to :game
  belongs_to :team
  belongs_to :current_level, class_name: 'Level'

  has_many :answer_attempts

  before_validation :start_with_first_level

  def advance_current_level!
    update_attribute :current_level, next_level
  end

  private

  def start_with_first_level
    self.current_level ||= game.levels.first
  end

  def next_level
    game.levels[game.levels.find_index(current_level) + 1]
  end
end
