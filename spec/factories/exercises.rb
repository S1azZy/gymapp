FactoryBot.define do
  factory :exercise do
    sequence(:key) { |n| "exercise_#{n}" }
    active { true }

    association :body_part
    association :muscle_group
    association :equipment_type
  end
end
