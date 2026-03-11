FactoryBot.define do
  factory :workout_template_exercise do
    association :workout_template
    association :exercise
    sequence(:position) { |n| n }
    planned_sets_count { nil }
    target_reps_min { nil }
    target_reps_max { nil }
    rest_seconds { nil }
    notes { nil }

    trait :with_prescription do
      planned_sets_count { 4 }
      target_reps_min { 8 }
      target_reps_max { 12 }
      rest_seconds { 90 }
      notes { "Controlled tempo" }
    end
  end
end
