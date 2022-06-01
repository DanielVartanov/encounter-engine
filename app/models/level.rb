# frozen_string_literal: true

class Level < ApplicationRecord
  belongs_to :game

  has_many :hints, -> { order(:delay_in_minutes) }, dependent: :destroy, inverse_of: :level

  def number_in_game
    game.levels.find_index(self) + 1
  end
end
