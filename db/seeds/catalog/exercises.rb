
module Seeds
  module Catalog
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
        "resistance_band_pull_apart", "upper_body", "shoulders", "resistance_band", %w[isolation pull horizontal_pull bilateral beginner_friendly],
        en_name: "Resistance band pull-apart", ru_name: "Разведение резинки перед собой",
        en_synonyms: [ "band pull-apart", "pull apart" ], ru_synonyms: [ "разведение резинки", "тяга резинки" ]
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
        "barbell_wrist_curl", "upper_body", "forearms", "barbell", %w[isolation pull bilateral beginner_friendly],
        en_name: "Barbell wrist curl", ru_name: "Сгибание кистей со штангой",
        en_synonyms: [ "wrist curl" ], ru_synonyms: [ "сгибание кистей" ]
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
        "goblet_squat", "lower_body", "quadriceps", "kettlebell", %w[compound squat_pattern bilateral beginner_friendly],
        en_name: "Goblet squat", ru_name: "Гоблет-присед",
        en_synonyms: [ "kettlebell goblet squat" ], ru_synonyms: [ "гоблет-присед с гирей", "присед с гирей" ]
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
        "kettlebell_swing", "full_body", "glutes", "kettlebell", %w[compound hinge_pattern bilateral beginner_friendly],
        en_name: "Kettlebell swing", ru_name: "Махи гирей",
        en_synonyms: [ "kb swing" ], ru_synonyms: [ "свинг гирей" ]
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
        "conventional_deadlift", "full_body", "lower_back", "barbell", %w[compound pull hinge_pattern bilateral],
        en_name: "Conventional deadlift", ru_name: "Классическая становая тяга",
        en_synonyms: [ "deadlift" ], ru_synonyms: [ "становая тяга" ]
      )
    ].freeze
  end
end
