class ExerciseTag < ApplicationRecord
  belongs_to :exercise
  belongs_to :tag

  validates :exercise, :tag, presence: true
  validates :tag_id, uniqueness: { scope: :exercise_id }
end
