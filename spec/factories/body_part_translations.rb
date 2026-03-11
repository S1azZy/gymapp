FactoryBot.define do
  factory :body_part_translation do
    association :body_part
    locale { "en" }
    sequence(:name) { |n| "Body Part #{n}" }
  end
end
