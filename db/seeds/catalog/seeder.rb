
module Seeds
  module Catalog
    module_function

    def seed_all!
      seed_reference_collection(BodyPart, :body_part_translations, BODY_PARTS)
      seed_reference_collection(MuscleGroup, :muscle_group_translations, MUSCLE_GROUPS)
      seed_reference_collection(EquipmentType, :equipment_type_translations, EQUIPMENT_TYPES)
      seed_reference_collection(Tag, :tag_translations, TAGS)
      seed_exercises
    end

    def seed_reference_collection(model_class, translation_association, rows)
      rows.each do |row|
        record = model_class.find_or_initialize_by(key: row.fetch(:key))
        record.assign_attributes(
          position: row.fetch(:position),
          active: true
        )
        record.save!

        upsert_translations(record.public_send(translation_association), row.fetch(:translations))
      end
    end

    def seed_exercises
      body_parts = BodyPart.all.index_by(&:key)
      muscle_groups = MuscleGroup.all.index_by(&:key)
      equipment_types = EquipmentType.all.index_by(&:key)
      tags = Tag.all.index_by(&:key)

      EXERCISES.each do |row|
        exercise = Exercise.find_or_initialize_by(key: row.fetch(:key))
        exercise.assign_attributes(
          body_part: body_parts.fetch(row.fetch(:body_part_key)),
          muscle_group: muscle_groups.fetch(row.fetch(:muscle_group_key)),
          equipment_type: equipment_types.fetch(row.fetch(:equipment_type_key)),
          active: true
        )
        exercise.save!

        exercise.tags = row.fetch(:tag_keys).map { |key| tags.fetch(key) }
        upsert_translations(exercise.exercise_translations, row.fetch(:translations))
      end
    end

    def upsert_translations(association, translations)
      translations.each do |locale, attributes|
        translation = association.find_or_initialize_by(locale: locale.to_s)
        translation.assign_attributes(attributes)
        translation.save!
      end
    end
  end
end
