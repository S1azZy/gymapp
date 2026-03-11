FactoryBot.define do
  factory :body_part do
    sequence(:key) { |n| "body_part_#{n}" }
    position { Constants::DEFAULT_REFERENCE_POSITION }
    active { true }
  end
end
