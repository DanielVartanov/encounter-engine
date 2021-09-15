require 'rails_helper'

RSpec.describe Play do
  let(:game) { create :game, :with_levels }

  describe 'setting to first level upon creation' do
    context 'when a Play is created' do
      let!(:play) { create :play, game: game }

      it 'sets to the first level of the game' do
        expect(play.current_level).to eq game.levels.first
      end
    end
  end

  describe '#advance_current_level!' do
    let(:play) { create :play, game: game }

    it 'changes current level of play to the next one' do
      expect { play.advance_current_level! }.to change(play, :current_level).to(game.levels.second)
      expect { play.advance_current_level! }.to change(play, :current_level).to(game.levels.third)
    end
  end
end
