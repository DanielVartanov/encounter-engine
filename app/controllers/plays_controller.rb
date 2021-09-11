class PlaysController < ApplicationController
  def play
    @play = game.plays.first || game.plays.create!
  end

  private

  def game
    @game ||= Game.find params.require(:game_id)
  end
end
