FactoryBot.define do
  factory :tag_translation do
    association :tag
    locale { "en" }
    sequence(:name) { |n| "Tag #{n}" }
  end
end
