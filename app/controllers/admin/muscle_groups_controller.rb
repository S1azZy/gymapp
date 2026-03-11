module Admin
  class MuscleGroupsController < LocalizedReferencesController
    private

    def model_class
      MuscleGroup
    end

    def translation_association
      :muscle_group_translations
    end
  end
end
