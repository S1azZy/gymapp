
module Seeds
  module Catalog
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
  end
end
