module Admin
  class TagsController < LocalizedReferencesController
    private

    def model_class
      Tag
    end

    def translation_association
      :tag_translations
    end
  end
end
