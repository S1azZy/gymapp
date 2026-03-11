class NormalizeReferenceLocalizationSchema < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      DROP INDEX IF EXISTS index_body_parts_on_lower_name;
      DROP INDEX IF EXISTS index_muscle_groups_on_lower_name;
      DROP INDEX IF EXISTS index_equipment_types_on_lower_name;
      DROP INDEX IF EXISTS index_tags_on_lower_name;
      DROP INDEX IF EXISTS index_exercises_on_lower_name;

      ALTER TABLE body_parts DROP COLUMN IF EXISTS name;
      ALTER TABLE muscle_groups DROP COLUMN IF EXISTS name;
      ALTER TABLE equipment_types DROP COLUMN IF EXISTS name;
      ALTER TABLE tags DROP COLUMN IF EXISTS name;

      ALTER TABLE exercises DROP COLUMN IF EXISTS name;
      ALTER TABLE exercises DROP COLUMN IF EXISTS description;
    SQL
  end

  def down
    execute <<~SQL
      ALTER TABLE body_parts ADD COLUMN IF NOT EXISTS name text;
      ALTER TABLE muscle_groups ADD COLUMN IF NOT EXISTS name text;
      ALTER TABLE equipment_types ADD COLUMN IF NOT EXISTS name text;
      ALTER TABLE tags ADD COLUMN IF NOT EXISTS name text;
      ALTER TABLE exercises ADD COLUMN IF NOT EXISTS name text;
      ALTER TABLE exercises ADD COLUMN IF NOT EXISTS description text;

      CREATE UNIQUE INDEX IF NOT EXISTS index_body_parts_on_lower_name ON body_parts (lower(name));
      CREATE UNIQUE INDEX IF NOT EXISTS index_muscle_groups_on_lower_name ON muscle_groups (lower(name));
      CREATE UNIQUE INDEX IF NOT EXISTS index_equipment_types_on_lower_name ON equipment_types (lower(name));
      CREATE UNIQUE INDEX IF NOT EXISTS index_tags_on_lower_name ON tags (lower(name));
      CREATE UNIQUE INDEX IF NOT EXISTS index_exercises_on_lower_name ON exercises (lower(name));
    SQL
  end
end
