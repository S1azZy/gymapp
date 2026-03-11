FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "supersecure123" }
    password_confirmation { password }
    role { "member" }
    preferred_locale { "en" }

    trait :admin do
      role { "admin" }
    end
  end
end
