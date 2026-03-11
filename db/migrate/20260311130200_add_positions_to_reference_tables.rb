class AddPositionsToReferenceTables < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      ALTER TABLE body_parts
      ADD COLUMN position integer NOT NULL DEFAULT 100;

      CREATE INDEX index_body_parts_on_position ON body_parts (position);

      ALTER TABLE muscle_groups
      ADD COLUMN position integer NOT NULL DEFAULT 100;

      CREATE INDEX index_muscle_groups_on_position ON muscle_groups (position);

      ALTER TABLE equipment_types
      ADD COLUMN position integer NOT NULL DEFAULT 100;

      CREATE INDEX index_equipment_types_on_position ON equipment_types (position);

      ALTER TABLE tags
      ADD COLUMN position integer NOT NULL DEFAULT 100;

      CREATE INDEX index_tags_on_position ON tags (position);
    SQL
  end

  def down
    execute <<~SQL
      DROP INDEX index_tags_on_position;
      ALTER TABLE tags DROP COLUMN position;

      DROP INDEX index_equipment_types_on_position;
      ALTER TABLE equipment_types DROP COLUMN position;

      DROP INDEX index_muscle_groups_on_position;
      ALTER TABLE muscle_groups DROP COLUMN position;

      DROP INDEX index_body_parts_on_position;
      ALTER TABLE body_parts DROP COLUMN position;
    SQL
  end
end
