FactoryBot.define do
  factory :muscle_group_translation do
    association :muscle_group
    locale { "en" }
    sequence(:name) { |n| "Muscle Group #{n}" }
  end
end
