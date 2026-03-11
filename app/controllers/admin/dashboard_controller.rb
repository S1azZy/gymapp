module Admin
  class DashboardController < BaseController
    RESOURCE_MODELS = {
      body_parts: BodyPart,
      muscle_groups: MuscleGroup,
      equipment_types: EquipmentType,
      tags: Tag,
      exercises: Exercise
    }.freeze

    def show
      @resource_cards = RESOURCE_MODELS.map do |resource_key, model_class|
        {
          resource_key:,
          count: model_class.count
        }
      end
    end
  end
end
