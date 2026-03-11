module Catalog
  module Exercises
    class List < ApplicationInteractor
      option :scope, default: proc { Exercise.all }
      option :locale
      option :filters, default: proc { {} }

      class ValidationContract < ApplicationContract
        params do
          required(:scope)
          required(:locale).filled(:string)
          required(:filters).value(:hash)
        end
      end

      def call
        Success(filtered_scope)
      end

      private

      def filtered_scope
        relation = scope
          .includes(:body_part, :muscle_group, :equipment_type, :tags, :exercise_translations)
          .where(active: true)

        relation = relation.where(body_part_id: body_part_id) if body_part_id.present?
        relation = relation.where(muscle_group_id: muscle_group_id) if muscle_group_id.present?
        relation = relation.where(equipment_type_id: equipment_type_id) if equipment_type_id.present?
        relation = relation.joins(:tags).where(tags: { id: tag_id }) if tag_id.present?
        relation = relation.where(search_sql, locale:, query: normalized_query) if query.present?

        relation.distinct
      end

      def search_sql
        <<~SQL.squish
          EXISTS (
            SELECT 1
            FROM exercise_translations
            WHERE exercise_translations.exercise_id = exercises.id
              AND exercise_translations.locale = :locale
              AND (
                LOWER(exercise_translations.name) LIKE :query
                OR EXISTS (
                  SELECT 1
                  FROM unnest(exercise_translations.synonyms) AS synonym
                  WHERE LOWER(synonym) LIKE :query
                )
              )
          )
        SQL
      end

      def normalized_query
        "%#{query.downcase}%"
      end

      def query
        @query ||= filters[:query].to_s.strip.presence
      end

      def body_part_id
        filters[:body_part_id].presence
      end

      def muscle_group_id
        filters[:muscle_group_id].presence
      end

      def equipment_type_id
        filters[:equipment_type_id].presence
      end

      def tag_id
        filters[:tag_id].presence
      end
    end
  end
end
