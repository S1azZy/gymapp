class MuscleGroup < ApplicationRecord
  has_many :muscle_group_translations, dependent: :destroy
  has_many :exercises, dependent: :restrict_with_exception

  def translation_for(locale = I18n.locale)
    muscle_group_translations.find_by(locale: locale.to_s)
  end

  def localized_name(locale = I18n.locale)
    translation_for(locale)&.name
  end
end
