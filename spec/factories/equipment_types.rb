FactoryBot.define do
  factory :equipment_type do
    sequence(:key) { |n| "equipment_type_#{n}" }
    position { Constants::DEFAULT_REFERENCE_POSITION }
    active { true }
  end
end
