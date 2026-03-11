class Exercise < ApplicationRecord
  belongs_to :body_part
  belongs_to :muscle_group
  belongs_to :equipment_type

  has_many :exercise_tags, dependent: :destroy
  has_many :tags, through: :exercise_tags
  has_many :exercise_translations, dependent: :destroy

  validates :body_part, :muscle_group, :equipment_type, presence: true

  def translation_for(locale = I18n.locale)
    exercise_translations.find_by(locale: locale.to_s)
  end

  def localized_name(locale = I18n.locale)
    translation_for(locale)&.name
  end
end
