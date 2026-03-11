module WorkoutTemplates
  class Destroy < ApplicationInteractor
    option :workout_template

    class ValidationContract < ApplicationContract
      params do
        required(:workout_template)
      end
    end

    def call
      workout_template.destroy!
      Success(workout_template)
    rescue ActiveRecord::ActiveRecordError
      Failure(code: :destroy_failed, workout_template:)
    end
  end
end
