class EquipmentType < ApplicationRecord
  has_many :equipment_type_translations, dependent: :destroy
  has_many :exercises, dependent: :restrict_with_exception

  normalizes :key, with: ->(value) { Constants.normalize_catalog_key(value) }

  validates :key,
    presence: true,
    uniqueness: true,
    format: { with: Constants::CATALOG_KEY_FORMAT }
  validates :position,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :key_is_immutable, on: :update

  def translation_for(locale = I18n.locale)
    equipment_type_translations.find_by(locale: locale.to_s)
  end

  def localized_name(locale = I18n.locale)
    translation_for(locale)&.name
  end

  private

  def key_is_immutable
    errors.add(:key, "cannot be changed") if will_save_change_to_key?
  end
end
