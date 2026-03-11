class MuscleGroupTranslation < ApplicationRecord
  belongs_to :muscle_group

  normalizes :name, with: ->(value) { value.to_s.strip }

  validates :muscle_group, presence: true
  validates :locale, presence: true, inclusion: { in: Constants::SUPPORTED_LOCALES }, uniqueness: { scope: :muscle_group_id }
  validates :name, presence: true, length: { maximum: 255 }
end
