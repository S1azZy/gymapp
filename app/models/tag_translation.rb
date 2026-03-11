class TagTranslation < ApplicationRecord
  SUPPORTED_LOCALES = %w[en ru].freeze

  belongs_to :tag

  normalizes :name, with: ->(value) { value.to_s.strip }

  validates :tag, presence: true
  validates :locale, presence: true, inclusion: { in: SUPPORTED_LOCALES }, uniqueness: { scope: :tag_id }
  validates :name, presence: true, length: { maximum: 255 }
end
