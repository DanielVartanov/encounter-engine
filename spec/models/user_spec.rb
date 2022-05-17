# frozen_string_literal: true

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

  describe '#name_with_team_tag' do
    subject { user.name_with_team_tag }

    context 'when user is a member of a team' do
      let(:team) { build :team, name: 'Hufflepuff' }
      let(:user) { build :user, name: 'Cedric Diggory', team: }

      it { is_expected.to eq 'Cedric Diggory [Hufflepuff]' }
    end

    context 'when user is not a member of a team' do
      let(:user) { build :user, name: 'Rubeus Hagrid' }

      it { is_expected.to eq 'Rubeus Hagrid' }
    end
  end
end
