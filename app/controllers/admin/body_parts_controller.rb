module Admin
  class BodyPartsController < LocalizedReferencesController
    private

    def model_class
      BodyPart
    end

    def translation_association
      :body_part_translations
    end
  end
end
