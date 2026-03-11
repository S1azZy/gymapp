# frozen_string_literal: true

module Seeds
  module Catalog
    module_function

    def exercise(key, body_part_key, muscle_group_key, equipment_type_key, tag_keys, en_name:, ru_name:, en_synonyms:, ru_synonyms:, en_description: nil, ru_description: nil)
      {
        key:,
        body_part_key:,
        muscle_group_key:,
        equipment_type_key:,
        tag_keys:,
        translations: {
          en: {
            name: en_name,
            description: en_description,
            synonyms: en_synonyms
          },
          ru: {
            name: ru_name,
            description: ru_description,
            synonyms: ru_synonyms
          }
        }
      }
    end

    BODY_PARTS = [
      {
        key: "upper_body",
        position: 10,
        translations: {
          en: { name: "Upper body" },
          ru: { name: "Верх тела" }
        }
      },
      {
        key: "lower_body",
        position: 20,
        translations: {
          en: { name: "Lower body" },
          ru: { name: "Низ тела" }
        }
      },
      {
        key: "core",
        position: 30,
        translations: {
          en: { name: "Core" },
          ru: { name: "Кор" }
        }
      },
      {
        key: "full_body",
        position: 40,
        translations: {
          en: { name: "Full body" },
          ru: { name: "Все тело" }
        }
      }
    ].freeze

    MUSCLE_GROUPS = [
      { key: "chest", position: 10, translations: { en: { name: "Chest" }, ru: { name: "Грудь" } } },
      { key: "back", position: 20, translations: { en: { name: "Back" }, ru: { name: "Спина" } } },
      { key: "shoulders", position: 30, translations: { en: { name: "Shoulders" }, ru: { name: "Плечи" } } },
      { key: "biceps", position: 40, translations: { en: { name: "Biceps" }, ru: { name: "Бицепс" } } },
      { key: "triceps", position: 50, translations: { en: { name: "Triceps" }, ru: { name: "Трицепс" } } },
      { key: "forearms", position: 60, translations: { en: { name: "Forearms" }, ru: { name: "Предплечья" } } },
      { key: "quadriceps", position: 70, translations: { en: { name: "Quadriceps" }, ru: { name: "Квадрицепсы" } } },
      { key: "hamstrings", position: 80, translations: { en: { name: "Hamstrings" }, ru: { name: "Бицепсы бедра" } } },
      { key: "glutes", position: 90, translations: { en: { name: "Glutes" }, ru: { name: "Ягодицы" } } },
      { key: "calves", position: 100, translations: { en: { name: "Calves" }, ru: { name: "Икры" } } },
      { key: "abs", position: 110, translations: { en: { name: "Abs" }, ru: { name: "Пресс" } } },
      { key: "lower_back", position: 120, translations: { en: { name: "Lower back" }, ru: { name: "Поясница" } } }
    ].freeze

    EQUIPMENT_TYPES = [
      { key: "bodyweight", position: 10, translations: { en: { name: "Bodyweight" }, ru: { name: "Собственный вес" } } },
      { key: "dumbbell", position: 20, translations: { en: { name: "Dumbbell" }, ru: { name: "Гантели" } } },
      { key: "barbell", position: 30, translations: { en: { name: "Barbell" }, ru: { name: "Штанга" } } },
      { key: "machine", position: 40, translations: { en: { name: "Machine" }, ru: { name: "Тренажер" } } },
      { key: "cable", position: 50, translations: { en: { name: "Cable" }, ru: { name: "Блочный тренажер" } } },
      { key: "kettlebell", position: 60, translations: { en: { name: "Kettlebell" }, ru: { name: "Гиря" } } },
      { key: "resistance_band", position: 70, translations: { en: { name: "Resistance band" }, ru: { name: "Резинка" } } },
      { key: "ez_bar", position: 80, translations: { en: { name: "EZ bar" }, ru: { name: "EZ-гриф" } } }
    ].freeze

    TAGS = [
      { key: "compound", position: 10, translations: { en: { name: "Compound" }, ru: { name: "Базовое" } } },
      { key: "isolation", position: 20, translations: { en: { name: "Isolation" }, ru: { name: "Изолирующее" } } },
      { key: "push", position: 30, translations: { en: { name: "Push" }, ru: { name: "Жимовое" } } },
      { key: "pull", position: 40, translations: { en: { name: "Pull" }, ru: { name: "Тяговое" } } },
      { key: "squat_pattern", position: 50, translations: { en: { name: "Squat pattern" }, ru: { name: "Приседательный паттерн" } } },
      { key: "hinge_pattern", position: 60, translations: { en: { name: "Hinge pattern" }, ru: { name: "Тазовый наклон" } } },
      { key: "lunge_pattern", position: 70, translations: { en: { name: "Lunge pattern" }, ru: { name: "Выпадовый паттерн" } } },
      { key: "horizontal_push", position: 80, translations: { en: { name: "Horizontal push" }, ru: { name: "Горизонтальный жим" } } },
      { key: "vertical_push", position: 90, translations: { en: { name: "Vertical push" }, ru: { name: "Вертикальный жим" } } },
      { key: "horizontal_pull", position: 100, translations: { en: { name: "Horizontal pull" }, ru: { name: "Горизонтальная тяга" } } },
      { key: "vertical_pull", position: 110, translations: { en: { name: "Vertical pull" }, ru: { name: "Вертикальная тяга" } } },
      { key: "unilateral", position: 120, translations: { en: { name: "Unilateral" }, ru: { name: "Одностороннее" } } },
      { key: "bilateral", position: 130, translations: { en: { name: "Bilateral" }, ru: { name: "Двустороннее" } } },
      { key: "beginner_friendly", position: 140, translations: { en: { name: "Beginner-friendly" }, ru: { name: "Подходит новичкам" } } }
    ].freeze

    EXERCISES = [
      exercise(
        "barbell_bench_press", "upper_body", "chest", "barbell", %w[compound push horizontal_push bilateral],
        en_name: "Barbell bench press", ru_name: "Жим штанги лежа",
        en_synonyms: [ "bench press", "flat bench" ], ru_synonyms: [ "жим лежа", "жим штанги" ],
        en_description: "Classic flat bench press with a barbell.",
        ru_description: "Классический жим штанги на горизонтальной скамье."
      ),
      exercise(
        "incline_dumbbell_press", "upper_body", "chest", "dumbbell", %w[compound push horizontal_push bilateral],
        en_name: "Incline dumbbell press", ru_name: "Жим гантелей на наклонной скамье",
        en_synonyms: [ "incline db press" ], ru_synonyms: [ "наклонный жим гантелей" ]
      ),
      exercise(
        "machine_chest_press", "upper_body", "chest", "machine", %w[compound push horizontal_push bilateral beginner_friendly],
        en_name: "Machine chest press", ru_name: "Жим в тренажере на грудь",
        en_synonyms: [ "chest press machine" ], ru_synonyms: [ "жим в тренажере" ]
      ),
      exercise(
        "push_up", "upper_body", "chest", "bodyweight", %w[compound push horizontal_push bilateral beginner_friendly],
        en_name: "Push-up", ru_name: "Отжимания",
        en_synonyms: [ "press-up" ], ru_synonyms: [ "отжимание" ]
      ),
      exercise(
        "pull_up", "upper_body", "back", "bodyweight", %w[compound pull vertical_pull bilateral],
        en_name: "Pull-up", ru_name: "Подтягивания",
        en_synonyms: [ "chin-up" ], ru_synonyms: [ "подтягивание" ]
      ),
      exercise(
        "lat_pulldown", "upper_body", "back", "cable", %w[compound pull vertical_pull bilateral beginner_friendly],
        en_name: "Lat pulldown", ru_name: "Тяга верхнего блока",
        en_synonyms: [ "lat pull-down" ], ru_synonyms: [ "верхний блок" ]
      ),
      exercise(
        "barbell_bent_over_row", "upper_body", "back", "barbell", %w[compound pull horizontal_pull bilateral],
        en_name: "Barbell bent-over row", ru_name: "Тяга штанги в наклоне",
        en_synonyms: [ "bent over row" ], ru_synonyms: [ "тяга в наклоне" ]
      ),
      exercise(
        "seated_cable_row", "upper_body", "back", "cable", %w[compound pull horizontal_pull bilateral beginner_friendly],
        en_name: "Seated cable row", ru_name: "Горизонтальная тяга блока",
        en_synonyms: [ "cable row" ], ru_synonyms: [ "горизонтальная тяга" ]
      ),
      exercise(
        "one_arm_dumbbell_row", "upper_body", "back", "dumbbell", %w[compound pull horizontal_pull unilateral],
        en_name: "One-arm dumbbell row", ru_name: "Тяга гантели одной рукой",
        en_synonyms: [ "single arm dumbbell row" ], ru_synonyms: [ "тяга гантели одной рукой" ]
      ),
      exercise(
        "face_pull", "upper_body", "shoulders", "cable", %w[isolation pull horizontal_pull beginner_friendly],
        en_name: "Face pull", ru_name: "Фейс пул",
        en_synonyms: [ "rope face pull" ], ru_synonyms: [ "тяга к лицу" ]
      ),
      exercise(
        "barbell_overhead_press", "upper_body", "shoulders", "barbell", %w[compound push vertical_push bilateral],
        en_name: "Barbell overhead press", ru_name: "Жим штанги над головой",
        en_synonyms: [ "overhead press", "military press" ], ru_synonyms: [ "армейский жим" ]
      ),
      exercise(
        "dumbbell_lateral_raise", "upper_body", "shoulders", "dumbbell", %w[isolation push unilateral],
        en_name: "Dumbbell lateral raise", ru_name: "Разведения гантелей в стороны",
        en_synonyms: [ "lateral raise" ], ru_synonyms: [ "махи в стороны" ]
      ),
      exercise(
        "barbell_curl", "upper_body", "biceps", "barbell", %w[isolation pull bilateral],
        en_name: "Barbell curl", ru_name: "Сгибание рук со штангой",
        en_synonyms: [ "biceps curl" ], ru_synonyms: [ "подъем на бицепс" ]
      ),
      exercise(
        "hammer_curl", "upper_body", "biceps", "dumbbell", %w[isolation pull unilateral],
        en_name: "Hammer curl", ru_name: "Молотковые сгибания",
        en_synonyms: [ "dumbbell hammer curl" ], ru_synonyms: [ "молотки" ]
      ),
      exercise(
        "triceps_pushdown", "upper_body", "triceps", "cable", %w[isolation push bilateral beginner_friendly],
        en_name: "Triceps pushdown", ru_name: "Разгибание рук на блоке",
        en_synonyms: [ "cable pushdown" ], ru_synonyms: [ "разгибание на блоке" ]
      ),
      exercise(
        "overhead_cable_triceps_extension", "upper_body", "triceps", "cable", %w[isolation push bilateral],
        en_name: "Overhead cable triceps extension", ru_name: "Разгибание рук над головой на блоке",
        en_synonyms: [ "overhead triceps extension" ], ru_synonyms: [ "разгибание над головой" ]
      ),
      exercise(
        "ez_bar_skull_crusher", "upper_body", "triceps", "ez_bar", %w[isolation push bilateral],
        en_name: "EZ-bar skull crusher", ru_name: "Французский жим с EZ-грифом",
        en_synonyms: [ "lying triceps extension" ], ru_synonyms: [ "французский жим" ]
      ),
      exercise(
        "back_squat", "lower_body", "quadriceps", "barbell", %w[compound squat_pattern bilateral],
        en_name: "Back squat", ru_name: "Присед со штангой на спине",
        en_synonyms: [ "barbell squat" ], ru_synonyms: [ "присед со штангой" ]
      ),
      exercise(
        "goblet_squat", "lower_body", "quadriceps", "dumbbell", %w[compound squat_pattern bilateral beginner_friendly],
        en_name: "Goblet squat", ru_name: "Гоблет-присед",
        en_synonyms: [ "dumbbell goblet squat" ], ru_synonyms: [ "присед с гантелью" ]
      ),
      exercise(
        "leg_press", "lower_body", "quadriceps", "machine", %w[compound squat_pattern bilateral beginner_friendly],
        en_name: "Leg press", ru_name: "Жим ногами",
        en_synonyms: [ "machine leg press" ], ru_synonyms: [ "пресс ногами" ]
      ),
      exercise(
        "bulgarian_split_squat", "lower_body", "quadriceps", "dumbbell", %w[compound lunge_pattern unilateral],
        en_name: "Bulgarian split squat", ru_name: "Болгарский сплит-присед",
        en_synonyms: [ "rear foot elevated split squat" ], ru_synonyms: [ "болгарские приседы" ]
      ),
      exercise(
        "leg_extension", "lower_body", "quadriceps", "machine", %w[isolation bilateral beginner_friendly],
        en_name: "Leg extension", ru_name: "Разгибание ног",
        en_synonyms: [ "machine leg extension" ], ru_synonyms: [ "разгибания ног" ]
      ),
      exercise(
        "romanian_deadlift", "lower_body", "hamstrings", "barbell", %w[compound hinge_pattern bilateral],
        en_name: "Romanian deadlift", ru_name: "Румынская тяга",
        en_synonyms: [ "rdl" ], ru_synonyms: [ "румынская становая" ]
      ),
      exercise(
        "seated_leg_curl", "lower_body", "hamstrings", "machine", %w[isolation bilateral beginner_friendly],
        en_name: "Seated leg curl", ru_name: "Сгибание ног сидя",
        en_synonyms: [ "machine leg curl" ], ru_synonyms: [ "сгибания ног сидя" ]
      ),
      exercise(
        "barbell_hip_thrust", "lower_body", "glutes", "barbell", %w[compound hinge_pattern bilateral],
        en_name: "Barbell hip thrust", ru_name: "Ягодичный мост со штангой",
        en_synonyms: [ "hip thrust" ], ru_synonyms: [ "ягодичный мост" ]
      ),
      exercise(
        "standing_calf_raise", "lower_body", "calves", "machine", %w[isolation bilateral],
        en_name: "Standing calf raise", ru_name: "Подъем на носки стоя",
        en_synonyms: [ "calf raise" ], ru_synonyms: [ "икры стоя" ]
      ),
      exercise(
        "hanging_knee_raise", "core", "abs", "bodyweight", %w[isolation bilateral],
        en_name: "Hanging knee raise", ru_name: "Подъем коленей в висе",
        en_synonyms: [ "knee raise" ], ru_synonyms: [ "колени в висе" ]
      ),
      exercise(
        "cable_crunch", "core", "abs", "cable", %w[isolation bilateral],
        en_name: "Cable crunch", ru_name: "Скручивания на блоке",
        en_synonyms: [ "kneeling cable crunch" ], ru_synonyms: [ "кранчи на блоке" ]
      ),
      exercise(
        "back_extension", "core", "lower_back", "machine", %w[isolation beginner_friendly],
        en_name: "Back extension", ru_name: "Гиперэкстензия",
        en_synonyms: [ "hyperextension" ], ru_synonyms: [ "гиперэкстензии" ]
      ),
      exercise(
        "conventional_deadlift", "full_body", "back", "barbell", %w[compound pull hinge_pattern bilateral],
        en_name: "Conventional deadlift", ru_name: "Классическая становая тяга",
        en_synonyms: [ "deadlift" ], ru_synonyms: [ "становая тяга" ]
      )
    ].freeze

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

Seeds::Catalog.seed_all!
