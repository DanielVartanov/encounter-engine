FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
  end
end
