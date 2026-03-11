FactoryBot.define do
  factory :exercise do
    active { true }

    association :body_part
    association :muscle_group
    association :equipment_type
  end
end
