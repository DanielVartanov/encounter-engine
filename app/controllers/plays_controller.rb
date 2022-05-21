# frozen_string_literal: true

class PlaysController < ApplicationController
  def show
    game = Game.find params.require(:game_id)
    @play = game.plays.where(team: current_team).first_or_create!
  end
end
