class EquipmentTypeTranslation < ApplicationRecord
  belongs_to :equipment_type

  normalizes :name, with: ->(value) { value.to_s.strip }

  validates :equipment_type, presence: true
  validates :locale, presence: true, inclusion: { in: Constants::SUPPORTED_LOCALES }, uniqueness: { scope: :equipment_type_id }
  validates :name, presence: true, length: { maximum: 255 }
end
