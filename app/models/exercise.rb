class Exercise < ApplicationRecord
  belongs_to :body_part
  belongs_to :muscle_group
  belongs_to :equipment_type

  has_many :exercise_tags, dependent: :destroy
  has_many :tags, through: :exercise_tags
  has_many :exercise_translations, dependent: :destroy

  normalizes :key, with: ->(value) { Constants.normalize_catalog_key(value) }

  validates :key,
    presence: true,
    uniqueness: true,
    format: { with: Constants::CATALOG_KEY_FORMAT }
  validates :body_part, :muscle_group, :equipment_type, presence: true
  validate :key_is_immutable, on: :update

  def translation_for(locale = I18n.locale)
    exercise_translations.find_by(locale: locale.to_s)
  end

  def localized_name(locale = I18n.locale)
    translation_for(locale)&.name
  end

  private

  def key_is_immutable
    errors.add(:key, "cannot be changed") if will_save_change_to_key?
  end
end
