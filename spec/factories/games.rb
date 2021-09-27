# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    name { Faker::Movie.title }

    trait :with_levels do
      after(:build) do |game|
        game.levels << build_list(:level, 3)
      end
    end
  end
end
