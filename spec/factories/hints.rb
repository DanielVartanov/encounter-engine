# frozen_string_literal: true

FactoryBot.define do
  factory :hint do
    text { Faker::Quote.singular_siegler }
    delay_in_minutes { rand 1..60 }
  end
end
