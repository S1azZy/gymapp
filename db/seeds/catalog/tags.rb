
module Seeds
  module Catalog
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
  end
end
