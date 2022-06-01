# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Play, 'hints' do
  let(:game) { create :game, :with_levels }
  let(:play) { create :play, game: }

  let(:first_level) { game.levels.first }
  let(:second_level) { game.levels.second }
  let(:third_level) { game.levels.third }

  let!(:first_level_hint_in_5_minutes) { create :hint, level: first_level, delay_in_minutes: 5 }

  let!(:second_level_hint_in_5_minutes) { create :hint, level: second_level, delay_in_minutes: 5 }
  let!(:second_level_hint_in_10_minutes) { create :hint, level: second_level, delay_in_minutes: 10 }
  let!(:second_level_hint_in_15_minutes) { create :hint, level: second_level, delay_in_minutes: 15 }

  let!(:third_level_hint_in_5_minutes) { create :hint, level: third_level, delay_in_minutes: 5 }

  describe '#available_hints' do
    subject { play.available_hints }

    before { play.advance_current_level! }

    context 'when latest_available_hint is nil' do
      before { play.latest_available_hint = nil }

      it { is_expected.to be_empty }
    end

    context 'when latest_available_hint equals to the first hint of the level' do
      before { play.latest_available_hint = second_level_hint_in_5_minutes }

      it { is_expected.to eq [second_level_hint_in_5_minutes] }
    end

    context 'when latest_available_hint equals to a middle hint of the level' do
      before { play.latest_available_hint = second_level_hint_in_10_minutes }

      it { is_expected.to eq [second_level_hint_in_5_minutes, second_level_hint_in_10_minutes] }
    end

    context 'when latest_available_hint equals to the last hint of the level' do
      before { play.latest_available_hint = second_level_hint_in_15_minutes }

      it { is_expected.to eq [second_level_hint_in_5_minutes, second_level_hint_in_10_minutes, second_level_hint_in_15_minutes] }
    end

    context 'when latest_available_hint equals to a hint which does not belong to the current level' do
      before { play.latest_available_hint = third_level_hint_in_5_minutes }

      it { is_expected.to be_empty }
    end
  end

  describe '#reevaluate_available_hints!' do
    subject { play }

    before { Timecop.freeze }
    after { Timecop.return }

    context 'before it is run first time' do
      its(:latest_available_hint) { is_expected.to be_nil }
      its(:available_hints) { is_expected.to be_empty }
    end

    context 'when the play has only reached next level' do
      before { play.advance_current_level! }

      before { play.reevaluate_available_hints! }

      its(:latest_available_hint) { is_expected.to be_nil }
      its(:available_hints) { is_expected.to be_empty }

      context 'when 4 minutes passed' do
        before { Timecop.freeze 4.minutes.from_now }

        before { play.reevaluate_available_hints! }

        its(:latest_available_hint) { is_expected.to be_nil }
        its(:available_hints) { is_expected.to be_empty }
      end

      context 'when 5 minutes passed' do
        before { Timecop.freeze 5.minutes.from_now }

        before { play.reevaluate_available_hints! }

        its(:latest_available_hint) { is_expected.to eq second_level_hint_in_5_minutes }
        its(:available_hints) { is_expected.to eq [second_level_hint_in_5_minutes] }
      end

      context 'when 9 minutes passed' do
        before { Timecop.freeze 9.minutes.from_now }

        before { play.reevaluate_available_hints! }

        its(:latest_available_hint) { is_expected.to eq second_level_hint_in_5_minutes }
        its(:available_hints) { is_expected.to eq [second_level_hint_in_5_minutes] }
      end

      context 'when 10 minutes passed' do
        before { Timecop.freeze 10.minutes.from_now }

        before { play.reevaluate_available_hints! }

        its(:latest_available_hint) { is_expected.to eq second_level_hint_in_10_minutes }
        its(:available_hints) { is_expected.to eq [second_level_hint_in_5_minutes, second_level_hint_in_10_minutes] }
      end

      context 'when 15 minutes passed' do
        before { Timecop.freeze 15.minutes.from_now }

        before { play.reevaluate_available_hints! }

        its(:latest_available_hint) { is_expected.to eq second_level_hint_in_15_minutes }
        its(:available_hints) { is_expected.to eq [second_level_hint_in_5_minutes, second_level_hint_in_10_minutes, second_level_hint_in_15_minutes] }

        context 'when the play advances to the next level' do
          before { play.advance_current_level! }

          its(:latest_available_hint) { is_expected.to be_nil }
          its(:available_hints) { is_expected.to be_empty }

          context 'when 5 minutes passed' do
            before { Timecop.freeze 5.minutes.from_now }

            before { play.reevaluate_available_hints! }

            its(:latest_available_hint) { is_expected.to eq third_level_hint_in_5_minutes }
            its(:available_hints) { is_expected.to eq [third_level_hint_in_5_minutes] }
          end
        end
      end
    end
  end
end
