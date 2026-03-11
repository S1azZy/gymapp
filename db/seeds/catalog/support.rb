
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
  end
end
