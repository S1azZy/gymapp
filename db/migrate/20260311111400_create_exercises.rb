class CreateExercises < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE exercises (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        body_part_id uuid NOT NULL,
        muscle_group_id uuid NOT NULL,
        equipment_type_id uuid NOT NULL,
        active boolean NOT NULL DEFAULT TRUE,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_exercises_body_parts
          FOREIGN KEY (body_part_id)
          REFERENCES body_parts (id)
          ON DELETE RESTRICT,
        CONSTRAINT fk_exercises_muscle_groups
          FOREIGN KEY (muscle_group_id)
          REFERENCES muscle_groups (id)
          ON DELETE RESTRICT,
        CONSTRAINT fk_exercises_equipment_types
          FOREIGN KEY (equipment_type_id)
          REFERENCES equipment_types (id)
          ON DELETE RESTRICT
      );

      CREATE INDEX index_exercises_on_body_part_id ON exercises (body_part_id);
      CREATE INDEX index_exercises_on_muscle_group_id ON exercises (muscle_group_id);
      CREATE INDEX index_exercises_on_equipment_type_id ON exercises (equipment_type_id);
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE exercises;
    SQL
  end
end
