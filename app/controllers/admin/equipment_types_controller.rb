module Admin
  class EquipmentTypesController < LocalizedReferencesController
    private

    def model_class
      EquipmentType
    end

    def translation_association
      :equipment_type_translations
    end
  end
end
