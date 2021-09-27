# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Level do
  describe '#number_in_game' do
    let(:game) { create :game }

    let!(:first_level) { create :level, game: game }
    let!(:second_level) { create :level, game: game }
    let!(:third_level) { create :level, game: game }

    specify do
      expect(first_level.number_in_game).to eq 1
      expect(second_level.number_in_game).to eq 2
      expect(third_level.number_in_game).to eq 3
    end
  end
end
