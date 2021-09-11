class AnswerAttemptsController < ApplicationController
  def create
    answer_attempt = play
                       .answer_attempts
                       .create_with(level: current_level)
                       .create! params.require(:answer_attempt).permit(:answer)

    redirect_to game_play_path(play.game)
  end

  private

  def play
    @play ||= Play.find params.require(:play_id)
  end

  def current_level
    play.current_level
  end
end
