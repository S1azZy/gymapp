class AddKeysToReferenceTables < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      ALTER TABLE body_parts
      ADD COLUMN key text;

      UPDATE body_parts
      SET key = 'body_part_' || substr(replace(id::text, '-', ''), 1, 12)
      WHERE key IS NULL;

      ALTER TABLE body_parts
      ALTER COLUMN key SET NOT NULL;

      CREATE UNIQUE INDEX index_body_parts_on_key ON body_parts (key);

      ALTER TABLE muscle_groups
      ADD COLUMN key text;

      UPDATE muscle_groups
      SET key = 'muscle_group_' || substr(replace(id::text, '-', ''), 1, 12)
      WHERE key IS NULL;

      ALTER TABLE muscle_groups
      ALTER COLUMN key SET NOT NULL;

      CREATE UNIQUE INDEX index_muscle_groups_on_key ON muscle_groups (key);

      ALTER TABLE equipment_types
      ADD COLUMN key text;

      UPDATE equipment_types
      SET key = 'equipment_type_' || substr(replace(id::text, '-', ''), 1, 12)
      WHERE key IS NULL;

      ALTER TABLE equipment_types
      ALTER COLUMN key SET NOT NULL;

      CREATE UNIQUE INDEX index_equipment_types_on_key ON equipment_types (key);

      ALTER TABLE tags
      ADD COLUMN key text;

      UPDATE tags
      SET key = 'tag_' || substr(replace(id::text, '-', ''), 1, 12)
      WHERE key IS NULL;

      ALTER TABLE tags
      ALTER COLUMN key SET NOT NULL;

      CREATE UNIQUE INDEX index_tags_on_key ON tags (key);
    SQL
  end

  def down
    execute <<~SQL
      DROP INDEX index_tags_on_key;
      ALTER TABLE tags DROP COLUMN key;

      DROP INDEX index_equipment_types_on_key;
      ALTER TABLE equipment_types DROP COLUMN key;

      DROP INDEX index_muscle_groups_on_key;
      ALTER TABLE muscle_groups DROP COLUMN key;

      DROP INDEX index_body_parts_on_key;
      ALTER TABLE body_parts DROP COLUMN key;
    SQL
  end
end
