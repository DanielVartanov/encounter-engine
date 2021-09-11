FactoryBot.define do
  factory :level do
    game
    name { Faker::Movie.quote }
    answer { Faker::Alphanumeric.alphanumeric(number: 8) }
  end
end
