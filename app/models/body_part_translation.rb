class BodyPartTranslation < ApplicationRecord
  SUPPORTED_LOCALES = %w[en ru].freeze

  belongs_to :body_part

  normalizes :name, with: ->(value) { value.to_s.strip }

  validates :body_part, presence: true
  validates :locale, presence: true, inclusion: { in: SUPPORTED_LOCALES }, uniqueness: { scope: :body_part_id }
  validates :name, presence: true, length: { maximum: 255 }
end
