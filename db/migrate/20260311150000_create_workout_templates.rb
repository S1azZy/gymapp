class CreateWorkoutTemplates < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE workout_templates (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        user_id uuid NOT NULL,
        name character varying(255) NOT NULL,
        notes text,
        active boolean NOT NULL DEFAULT TRUE,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_workout_templates_users
          FOREIGN KEY (user_id)
          REFERENCES users (id)
          ON DELETE CASCADE
      );

      CREATE INDEX index_workout_templates_on_user_id
        ON workout_templates (user_id);
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE workout_templates;
    SQL
  end
end
