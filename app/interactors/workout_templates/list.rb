module WorkoutTemplates
  class List < ApplicationInteractor
    option :user

    class ValidationContract < ApplicationContract
      params do
        required(:user)
      end
    end

    def call
      workout_templates = WorkoutTemplatePolicy::Scope.new(user, WorkoutTemplate)
        .resolve
        .order(created_at: :desc)

      Success(workout_templates)
    end
  end
end
