FactoryBot.define do
  factory :workout_template do
    association :user
    sequence(:name) { |n| "Workout Template #{n}" }
    notes { nil }
    active { true }
  end
end
