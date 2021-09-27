# frozen_string_literal: true

class AnswerAttempt < ApplicationRecord
  belongs_to :play
  belongs_to :level

  after_create :advance_current_level

  def correct?
    answer == level.answer
  end

  private

  def advance_current_level
    play.advance_current_level! if correct?
  end
end
