class PasswordResetToken < ApplicationRecord
  RESET_WINDOW = 30.minutes

  belongs_to :user

  validates :token_digest, presence: true, uniqueness: true
  validates :expires_at, presence: true
  validates :user, presence: true

  scope :active, -> { where(used_at: nil).where("expires_at > ?", Time.current) }

  def self.digest(raw_token)
    Digest::SHA256.hexdigest(raw_token)
  end

  def expired?
    expires_at <= Time.current
  end

  def used?
    used_at.present?
  end

  def active?
    !used? && !expired?
  end
end
