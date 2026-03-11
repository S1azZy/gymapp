FactoryBot.define do
  factory :tag do
    sequence(:key) { |n| "tag_#{n}" }
    position { Constants::DEFAULT_REFERENCE_POSITION }
    active { true }
  end
end
