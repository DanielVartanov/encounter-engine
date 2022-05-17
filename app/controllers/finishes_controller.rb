# frozen_string_literal: true

class FinishesController < ApplicationController
  def show
    game = Game.find params.require(:game_id)
    @play = game.plays.where(team: current_team).first!

    redirect_to game_play_path(game) unless @play.finished?
  end
end
