class Tag < ApplicationRecord
  has_many :tag_translations, dependent: :destroy
  has_many :exercise_tags, dependent: :destroy
  has_many :exercises, through: :exercise_tags

  def translation_for(locale = I18n.locale)
    tag_translations.find_by(locale: locale.to_s)
  end

  def localized_name(locale = I18n.locale)
    translation_for(locale)&.name
  end
end
