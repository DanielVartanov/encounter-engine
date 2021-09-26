require 'rails_helper'

RSpec.describe User do
  describe '#member_of_any_team?' do
    subject { user.member_of_any_team? }

    context 'when user is a member of a team' do
      let(:user) { build :user, team: build(:team) }

      it { is_expected.to be true }
    end

    context 'when user is not a member of a team' do
      let(:user) { build :user }

      it { is_expected.to be false }
    end
  end
end
