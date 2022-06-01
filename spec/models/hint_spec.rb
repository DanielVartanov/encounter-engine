# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hint do
  describe '#available_for?' do
    let!(:play) { create :play }

    before { Timecop.freeze }

    subject { hint.available_for?(play) }

    context 'when the hint does not belong to current level of the play' do
      let(:hint) { build :hint, level: play.next_level, delay_in_minutes: 0 }

      it { is_expected.to be_falsey }
    end

    context 'when the hint belongs to current level of the play' do
      let(:hint) { build :hint, level: play.current_level, delay_in_minutes: 5 }

      context 'when not enough time passed since reaching the level' do
        before { Timecop.freeze 4.minutes.from_now }

        it { is_expected.to be_falsey }
      end

      context 'when enough time passed since reaching the level' do
        before { Timecop.freeze 5.minutes.from_now }

        it { is_expected.to be_truthy }
      end
    end
  end
end
