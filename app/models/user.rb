class User < ApplicationRecord
  has_secure_password

  enum :role, { member: "member", admin: "admin" }, default: :member, validate: true

  has_many :password_reset_tokens, dependent: :destroy
  has_many :user_sessions, dependent: :destroy

  normalizes :email, with: ->(value) { value.strip.downcase }

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP },
    length: { maximum: 255 }
  validates :password, length: { minimum: 12 }, allow_nil: true
end
