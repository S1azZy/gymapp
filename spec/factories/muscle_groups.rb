FactoryBot.define do
  factory :muscle_group do
    sequence(:key) { |n| "muscle_group_#{n}" }
    position { Constants::DEFAULT_REFERENCE_POSITION }
    active { true }
  end
end
