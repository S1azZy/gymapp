
module Seeds
  module Catalog
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
  end
end
