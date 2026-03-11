class CreateExerciseTags < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE exercise_tags (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        exercise_id uuid NOT NULL,
        tag_id uuid NOT NULL,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_exercise_tags_exercises
          FOREIGN KEY (exercise_id)
          REFERENCES exercises (id)
          ON DELETE CASCADE,
        CONSTRAINT fk_exercise_tags_tags
          FOREIGN KEY (tag_id)
          REFERENCES tags (id)
          ON DELETE CASCADE
      );

      CREATE UNIQUE INDEX index_exercise_tags_on_exercise_id_and_tag_id
        ON exercise_tags (exercise_id, tag_id);
      CREATE INDEX index_exercise_tags_on_tag_id ON exercise_tags (tag_id);
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE exercise_tags;
    SQL
  end
end
