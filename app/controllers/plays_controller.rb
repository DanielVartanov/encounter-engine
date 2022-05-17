# frozen_string_literal: true

class PlaysController < ApplicationController
  def show
    game = Game.find params.require(:game_id)
    @play = game.plays.where(team: current_team).first_or_create!

    redirect_to game_finish_path(game) if @play.finished?
  end
end
