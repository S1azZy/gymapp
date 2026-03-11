class CreateEquipmentTypeTranslations < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE equipment_type_translations (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        equipment_type_id uuid NOT NULL,
        locale character varying NOT NULL,
        name text NOT NULL,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_equipment_type_translations_equipment_types
          FOREIGN KEY (equipment_type_id)
          REFERENCES equipment_types (id)
          ON DELETE CASCADE
      );

      CREATE UNIQUE INDEX idx_eq_type_tr_on_eq_type_id_locale
        ON equipment_type_translations (equipment_type_id, locale);
      CREATE INDEX index_equipment_type_translations_on_locale_and_lower_name
        ON equipment_type_translations (locale, lower(name));
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE equipment_type_translations;
    SQL
  end
end
