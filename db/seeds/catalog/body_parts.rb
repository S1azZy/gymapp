
module Seeds
  module Catalog
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
  end
end
