FactoryBot.define do
  factory :share do
    content { Faker::Lorem.characters(number: 30) }
    user
    goal
    category
  end
end
