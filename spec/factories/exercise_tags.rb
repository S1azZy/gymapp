FactoryBot.define do
  factory :exercise_tag do
    association :exercise
    association :tag
  end
end
