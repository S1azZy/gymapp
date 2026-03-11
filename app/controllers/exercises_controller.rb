class ExercisesController < ApplicationController
  before_action :require_authentication
  before_action :load_filter_collections, only: :index
  before_action :set_exercise, only: :show

  helper_method :catalog_filters

  def index
    authorize :exercise, :index?

    result = Catalog::Exercises::List.call(
      locale: I18n.locale.to_s,
      filters: catalog_filters.to_h.symbolize_keys
    )

    @exercises = result.value!.sort_by { |exercise| catalog_exercise_name(exercise).downcase }
  end

  def show
    authorize @exercise, :show?
  end

  private

  def set_exercise
    @exercise = Exercise.includes(:body_part, :muscle_group, :equipment_type, :tags, :exercise_translations)
      .find(params[:id])
  end

  def catalog_filters
    params.fetch(:filters, {}).permit(:query, :body_part_id, :muscle_group_id, :equipment_type_id, :tag_id)
  end

  def load_filter_collections
    @body_parts = filter_collection(BodyPart, :body_part_translations)
    @muscle_groups = filter_collection(MuscleGroup, :muscle_group_translations)
    @equipment_types = filter_collection(EquipmentType, :equipment_type_translations)
    @tags = filter_collection(Tag, :tag_translations)
  end

  def filter_collection(model_class, translation_association)
    model_class.includes(translation_association).where(active: true).order(position: :asc, created_at: :asc)
  end

  def catalog_exercise_name(exercise)
    exercise.localized_name || exercise.localized_name(:en) || exercise.key
  end
end
