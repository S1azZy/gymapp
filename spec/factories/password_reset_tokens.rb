FactoryBot.define do
  factory :password_reset_token do
    association :user
    token_digest { PasswordResetToken.digest("reset-token") }
    expires_at { 30.minutes.from_now }
    used_at { nil }
  end
end
