FactoryBot.define do
  factory :report do
    comment { Faker::Lorem.characters(number: 30) }
    fulness { Faker::Lorem.characters(number: 1) }
    task_all { Faker::Lorem.characters(number: 1) }
    task_progress { Faker::Lorem.characters(number: 1) }
    goal
  end
end
