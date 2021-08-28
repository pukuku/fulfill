FactoryBot.define do
  factory :goal do
    content { Faker::Lorem.characters(number: 10) }
    user
  end
end
