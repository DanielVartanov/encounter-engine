# frozen_string_literal: true

class Level < ApplicationRecord
  belongs_to :game

  has_many :hints, dependent: :destroy

  def number_in_game
    game.levels.find_index(self) + 1
  end
end
