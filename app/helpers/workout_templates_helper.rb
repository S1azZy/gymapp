module WorkoutTemplatesHelper
  def workout_template_status_text(workout_template)
    status_key = workout_template.active? ? :active : :inactive
    t("workout_templates.statuses.#{status_key}")
  end

  def workout_template_exercise_count_text(workout_template)
    t(
      "workout_templates.meta.exercise_count",
      count: workout_template.workout_template_exercises.size
    )
  end

  def workout_template_updated_at_text(workout_template)
    t(
      "workout_templates.meta.updated_at",
      updated_at: l(workout_template.updated_at, format: :short)
    )
  end

  def workout_template_exercise_position_text(template_exercise)
    t("workout_templates.meta.position", position: template_exercise.position)
  end

  def workout_template_exercise_sets_text(template_exercise)
    return unless template_exercise.planned_sets_count.present?

    t(
      "workout_templates.meta.sets",
      count: template_exercise.planned_sets_count
    )
  end

  def workout_template_exercise_reps_text(template_exercise)
    min_reps = template_exercise.target_reps_min
    max_reps = template_exercise.target_reps_max

    return if min_reps.blank?
    return t("workout_templates.meta.reps_from", min: min_reps) if max_reps.blank?

    t("workout_templates.meta.reps_range", min: min_reps, max: max_reps)
  end

  def workout_template_exercise_rest_text(template_exercise)
    return unless template_exercise.rest_seconds.present?

    t("workout_templates.meta.rest_seconds", count: template_exercise.rest_seconds)
  end

  def workout_template_exercise_name(template_exercise)
    localized_exercise_name(template_exercise.exercise)
  end

  def workout_template_exercise_classification_text(template_exercise)
    catalog_exercise_classification_text(template_exercise.exercise)
  end
end
