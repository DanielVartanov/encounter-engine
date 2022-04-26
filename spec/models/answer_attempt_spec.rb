# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerAttempt do
  describe '#correct?' do
    let(:level) { create :level, answer: 'correct' }
    let(:answer_attempt) { build :answer_attempt, level:, answer: given_answer }

    subject { answer_attempt.correct? }

    context 'when the answer is correct' do
      let(:given_answer) { 'correct' }

      it { is_expected.to be true }
    end

    context 'when the answer is incorrect' do
      let(:given_answer) { 'incorrect' }

      it { is_expected.to be false }
    end
  end

  describe 'current level advancement upon creation' do
    let(:game) { create :game }
    let!(:first_level) { create :level, game:, answer: 'correct' }
    let!(:second_level) { create :level, game: }
    let(:play) { create :play, game:, current_level: first_level }

    subject(:creation) { play.answer_attempts.create! level: first_level, answer: given_answer }

    context 'when AnswerAttempt with a correct answer is created' do
      let(:given_answer) { 'correct' }

      it 'advances current level of the play' do
        expect { creation }.to change(play, :current_level)
                                 .from(first_level)
                                 .to(second_level)
      end
    end

    context 'when AnswerAttempt with an incorrect answer is created' do
      let(:given_answer) { 'incorrect' }

      it 'does not advance current level of the play' do
        expect { creation }.not_to change(play, :current_level)
      end
    end
  end
end
