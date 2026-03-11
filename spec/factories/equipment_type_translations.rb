FactoryBot.define do
  factory :equipment_type_translation do
    association :equipment_type
    locale { "en" }
    sequence(:name) { |n| "Equipment Type #{n}" }
  end
end
