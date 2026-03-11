module Admin
  module Exercises
    class Destroy < ApplicationInteractor
      option :exercise

      class ValidationContract < ApplicationContract
        params do
          required(:exercise)
        end
      end

      def call
        exercise.destroy!
        Success(exercise)
      rescue ActiveRecord::DeleteRestrictionError, ActiveRecord::InvalidForeignKey
        Failure(code: :destroy_failed, exercise:)
      end
    end
  end
end
