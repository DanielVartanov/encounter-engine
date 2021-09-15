class PlaysController < ApplicationController
  def play
    @play = game.plays.where(team: current_team).first_or_create!
  end

  private

  def game
    @game ||= Game.find params.require(:game_id)
  end
end
