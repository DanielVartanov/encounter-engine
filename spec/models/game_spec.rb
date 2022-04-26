# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game do
  let(:game) { build :game, :with_levels }

  describe '#last_level' do
    subject { game.last_level }

    let!(:expected_last_level) do
      build(:level).tap do |level|
        game.levels << level
      end
    end

    it { is_expected.to eq expected_last_level }
  end
end
