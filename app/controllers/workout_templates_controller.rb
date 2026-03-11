class WorkoutTemplatesController < ApplicationController
  before_action :require_authentication
  before_action :set_workout_template, only: %i[show edit update destroy]

  def index
    authorize WorkoutTemplate
    @workout_templates = WorkoutTemplates::List.call(user: current_user).value!
  end

  def show
    authorize @workout_template
  end

  def new
    @workout_template = current_user.workout_templates.new(active: true)
    authorize @workout_template
  end

  def create
    @workout_template = current_user.workout_templates.new
    authorize @workout_template

    result = WorkoutTemplates::Upsert.call(
      workout_template: @workout_template,
      workout_template_attributes:
    )

    if result.success?
      redirect_to workout_template_path(result.value!), notice: t("workout_templates.flash.created")
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    authorize @workout_template
  end

  def update
    authorize @workout_template

    result = WorkoutTemplates::Upsert.call(
      workout_template: @workout_template,
      workout_template_attributes:
    )

    if result.success?
      redirect_to workout_template_path(result.value!), notice: t("workout_templates.flash.updated")
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @workout_template

    result = WorkoutTemplates::Destroy.call(workout_template: @workout_template)

    if result.success?
      redirect_to workout_templates_path, notice: t("workout_templates.flash.destroyed")
    else
      redirect_to workout_templates_path, alert: t("workout_templates.flash.destroy_failed")
    end
  end

  private

  def set_workout_template
    @workout_template = WorkoutTemplate.includes(workout_template_exercises: {
      exercise: %i[body_part muscle_group equipment_type exercise_translations]
    }).find(params[:id])
  end

  def workout_template_attributes
    params.fetch(:workout_template, {}).permit(:name, :notes, :active).to_h
  end
end
