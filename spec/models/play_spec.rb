require 'rails_helper'

RSpec.describe Play do
  describe 'setting to first level upon creation' do
    context 'when a Play is created' do
      let(:game) { create :game, :with_levels }
      let!(:play) { game.plays.create! }

      it 'sets to the first level of the game' do
        expect(play.current_level).to eq game.levels.first
      end
    end
  end

  describe '#advance_current_level!' do
    let(:game) { create :game, :with_levels }
    let(:play) { game.plays.create! }

    it 'changes current level of play to the next one' do
      expect { play.advance_current_level! }.to change(play, :current_level).to(game.levels.second)
      expect { play.advance_current_level! }.to change(play, :current_level).to(game.levels.third)
    end
  end
end
