class CreateEquipmentTypes < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE equipment_types (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        active boolean NOT NULL DEFAULT TRUE,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE equipment_types;
    SQL
  end
end
