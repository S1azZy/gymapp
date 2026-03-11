FactoryBot.define do
  factory :exercise_translation do
    association :exercise
    locale { "en" }
    sequence(:name) { |n| "Exercise Translation #{n}" }
    description { "Localized exercise description." }
    synonyms { [ "alt name", "second alias" ] }
  end
end
