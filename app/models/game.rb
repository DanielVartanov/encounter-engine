# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :levels
  has_many :plays
end
