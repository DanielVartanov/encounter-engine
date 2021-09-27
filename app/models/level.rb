# frozen_string_literal: true

class Level < ApplicationRecord
  belongs_to :game

  def number_in_game
    game.levels.find_index(self) + 1
  end
end
