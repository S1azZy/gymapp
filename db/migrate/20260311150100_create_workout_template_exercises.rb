class CreateWorkoutTemplateExercises < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE workout_template_exercises (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        workout_template_id uuid NOT NULL,
        exercise_id uuid NOT NULL,
        position integer NOT NULL,
        planned_sets_count integer,
        target_reps_min integer,
        target_reps_max integer,
        rest_seconds integer,
        notes text,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_wt_ex_templates
          FOREIGN KEY (workout_template_id)
          REFERENCES workout_templates (id)
          ON DELETE CASCADE,
        CONSTRAINT fk_wt_ex_exercises
          FOREIGN KEY (exercise_id)
          REFERENCES exercises (id)
          ON DELETE RESTRICT
      );

      CREATE INDEX idx_wt_ex_on_template_id
        ON workout_template_exercises (workout_template_id);
      CREATE INDEX idx_wt_ex_on_exercise_id
        ON workout_template_exercises (exercise_id);
      CREATE UNIQUE INDEX idx_wt_ex_on_template_id_position
        ON workout_template_exercises (workout_template_id, position);
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE workout_template_exercises;
    SQL
  end
end
