# frozen_string_literal: true

class AnswerAttemptsController < ApplicationController
  def create
    game = Game.find params.require(:game_id)
    play = game.plays.where(team: current_team).first!
    current_level = play.current_level

    play
      .answer_attempts
      .create_with(level: current_level)
      .create! params.require(:answer_attempt).permit(:answer)

    redirect_to game_play_path(game)
  end
end
