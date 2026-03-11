module Admin
  class ExercisesController < BaseController
    before_action :set_exercise, only: %i[edit update destroy]

    helper_method :exercise_collection, :exercise_tags_for_form, :exercise_translations_for_form,
      :exercise_reference_options

    def index
      @exercises = Exercise.includes(
        :body_part,
        :muscle_group,
        :equipment_type,
        :tags,
        :exercise_translations
      ).order(created_at: :desc)
    end

    def new
      @exercise = Exercise.new(active: true)
      ensure_translations(@exercise)
    end

    def edit
      ensure_translations(@exercise)
    end

    def create
      @exercise = Exercise.new
      result = Admin::Exercises::Upsert.call(
        exercise: @exercise,
        exercise_attributes:
      )

      if result.success?
        redirect_to admin_exercises_path, notice: t("admin.exercises.flash.created")
      else
        render_invalid_exercise(result.failure[:exercise], :new)
      end
    end

    def update
      result = Admin::Exercises::Upsert.call(
        exercise: @exercise,
        exercise_attributes:
      )

      if result.success?
        redirect_to admin_exercises_path, notice: t("admin.exercises.flash.updated")
      else
        render_invalid_exercise(result.failure[:exercise], :edit)
      end
    end

    def destroy
      result = Admin::Exercises::Destroy.call(exercise: @exercise)

      if result.success?
        redirect_to admin_exercises_path, notice: t("admin.exercises.flash.destroyed")
      else
        redirect_to admin_exercises_path, alert: t("admin.exercises.flash.destroy_failed")
      end
    end

    private

    def set_exercise
      @exercise = Exercise.includes(:tags, :exercise_translations).find(params[:id])
    end

    def render_invalid_exercise(exercise, template)
      @exercise = exercise
      ensure_translations(@exercise)
      render template, status: :unprocessable_content
    end

    def ensure_translations(exercise)
      Constants::SUPPORTED_LOCALE_KEYS.each do |locale|
        exercise.exercise_translations.find_or_initialize_by(locale: locale.to_s)
      end
    end

    def exercise_collection
      @exercise || Exercise.new
    end

    def exercise_tags_for_form
      exercise_collection.tag_ids
    end

    def exercise_translations_for_form
      exercise_collection.exercise_translations.index_by(&:locale)
    end

    def exercise_reference_options(model_class)
      translation_assoc = model_class.reflect_on_all_associations(:has_many).first.name
      model_class.includes(translation_assoc).order(position: :asc, created_at: :asc)
    end

    def exercise_attributes
      params.fetch(:exercise, {}).permit(
        :key,
        :active,
        :body_part_id,
        :muscle_group_id,
        :equipment_type_id,
        tag_ids: [],
        translations: Constants::SUPPORTED_LOCALE_KEYS.index_with { [ :name, :description, :synonyms_csv ] }
      ).to_h
    end
  end
end
