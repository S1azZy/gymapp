class ExerciseTranslation < ApplicationRecord
  belongs_to :exercise

  normalizes :name, with: ->(value) { value.to_s.strip }
  normalizes :description, with: ->(value) { value.to_s.strip }

  validates :exercise, presence: true
  validates :locale, presence: true, inclusion: { in: Constants::SUPPORTED_LOCALES }
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 2000 }
  validates :locale, uniqueness: { scope: :exercise_id }

  before_validation :normalize_synonyms

  def synonyms_csv
    synonyms.join(", ")
  end

  def synonyms_csv=(value)
    self.synonyms = value.to_s.split(",")
  end

  private

  def normalize_synonyms
    self.synonyms = Array(synonyms)
      .map { |synonym| synonym.to_s.strip }
      .reject(&:blank?)
      .uniq
  end
end
