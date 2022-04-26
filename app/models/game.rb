# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :levels, dependent: :destroy
  has_many :plays, dependent: :restrict_with_error

  def last_level
    self.levels.last
  end
end
