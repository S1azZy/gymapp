module WorkoutTemplates
  class Upsert < ApplicationInteractor
    option :workout_template
    option :workout_template_attributes

    class ValidationContract < ApplicationContract
      params do
        required(:workout_template)
        required(:workout_template_attributes).filled(:hash)
      end
    end

    def call
      workout_template.assign_attributes(
        name: attribute_value(:name),
        notes: attribute_value(:notes),
        active: active_value
      )

      return Failure(code: :invalid_attributes, workout_template:) unless workout_template.valid?

      workout_template.save!
      Success(workout_template)
    end

    private

    def attribute_value(key)
      workout_template_attributes[key.to_s] || workout_template_attributes[key]
    end

    def active_value
      ActiveModel::Type::Boolean.new.cast(attribute_value(:active))
    end
  end
end
