# frozen_string_literal: true

FactoryBot.define do
  factory :answer_attempt do
    play
    level
    answer { Faker::Alphanumeric.alphanumeric(number: 8) }
  end
end
