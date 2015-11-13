# -*- encoding : utf-8 -*-
class Log < ActiveRecord::Base
  belongs_to :game

  scope :of_game, ->(game) { where(game_id: game) }
  scope :of_team, ->(team) { where(team: team.name) }
  scope :of_level, ->(level) { where(level: level.name) }
end
