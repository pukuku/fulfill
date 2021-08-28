FactoryBot.define do
  factory :task do
    content { Faker::Lorem.characters(number: 10) }
    goal
  end
end
