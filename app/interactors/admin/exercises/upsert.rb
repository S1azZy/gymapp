module Admin
  module Exercises
    class Upsert < ApplicationInteractor
      option :exercise
      option :exercise_attributes

      class ValidationContract < ApplicationContract
        params do
          required(:exercise)
          required(:exercise_attributes).filled(:hash)
        end
      end

      def call
        assign_base_attributes
        assign_tags
        assign_translations

        return Failure(code: :invalid_attributes, exercise: invalid_exercise) unless valid_exercise?

        in_transaction do
          exercise.save!
          translations_to_persist.each(&:save!)
        end

        Success(exercise)
      end

      private

      def assign_base_attributes
        exercise.assign_attributes(
          active: active_value,
          body_part_id: attribute_value("body_part_id"),
          muscle_group_id: attribute_value("muscle_group_id"),
          equipment_type_id: attribute_value("equipment_type_id")
        )
      end

      def assign_tags
        exercise.tag_ids = normalized_tag_ids
      end

      def assign_translations
        existing_translations = exercise.exercise_translations.to_a

        @translations_to_persist = Constants::SUPPORTED_LOCALE_KEYS.map do |locale|
          locale_value = locale.to_s
          translation = existing_translations.find { |item| item.locale == locale_value }
          translation ||= exercise.exercise_translations.build(locale: locale_value)
          translation.name = translation_attribute(locale_value, "name")
          translation.description = translation_attribute(locale_value, "description")
          translation.synonyms_csv = translation_attribute(locale_value, "synonyms_csv")
          translation
        end
      end

      def translation_attributes(locale)
        translations = attribute_value("translations") || {}
        translations[locale] || translations[locale.to_sym] || {}
      end

      def translation_attribute(locale, key)
        attributes = translation_attributes(locale)
        attributes[key] || attributes[key.to_sym]
      end

      def normalized_tag_ids
        Array(attribute_value("tag_ids")).reject(&:blank?)
      end

      def active_value
        ActiveModel::Type::Boolean.new.cast(attribute_value("active"))
      end

      def attribute_value(key)
        exercise_attributes[key] || exercise_attributes[key.to_sym]
      end

      def translations_to_persist
        @translations_to_persist || exercise.exercise_translations.to_a
      end

      def valid_exercise?
        exercise.valid?
        translations_to_persist.all?(&:valid?)
      end

      def invalid_exercise
        translations_to_persist.each do |translation|
          translation.errors.each do |error|
            exercise.errors.add(error.attribute, error.message)
          end
        end

        exercise
      end
    end
  end
end
