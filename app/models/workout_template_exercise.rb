class WorkoutTemplateExercise < ApplicationRecord
  belongs_to :workout_template
  belongs_to :exercise

  normalizes :notes, with: ->(value) { value.to_s.strip.presence }

  validates :workout_template, :exercise, presence: true
  validates :position,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 },
    uniqueness: { scope: :workout_template_id }
  validates :planned_sets_count,
    numericality: { only_integer: true, greater_than: 0 },
    allow_nil: true
  validates :target_reps_min,
    numericality: { only_integer: true, greater_than: 0 },
    allow_nil: true
  validates :target_reps_max,
    numericality: { only_integer: true, greater_than: 0 },
    allow_nil: true
  validates :rest_seconds,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    allow_nil: true
  validates :notes, length: { maximum: 2000 }

  validate :target_reps_range_is_valid

  private

  def target_reps_range_is_valid
    return if target_reps_min.blank? || target_reps_max.blank?
    return if target_reps_min <= target_reps_max

    errors.add(:target_reps_max, "must be greater than or equal to target reps min")
  end
end
