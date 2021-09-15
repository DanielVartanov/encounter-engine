FactoryBot.define do
  factory :play do
    game { create :game, :with_levels }
    team
  end
end
