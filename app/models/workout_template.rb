class WorkoutTemplate < ApplicationRecord
  belongs_to :user

  has_many :workout_template_exercises,
    -> { order(position: :asc, created_at: :asc) },
    dependent: :destroy
  has_many :exercises, through: :workout_template_exercises

  normalizes :name, with: ->(value) { value.to_s.strip }
  normalizes :notes, with: ->(value) { value.to_s.strip.presence }

  validates :user, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :notes, length: { maximum: 2000 }
end
