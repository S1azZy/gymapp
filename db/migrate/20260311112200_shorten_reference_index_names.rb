class ShortenReferenceIndexNames < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      DROP INDEX IF EXISTS index_equipment_type_translations_on_equipment_type_id_and_locale;

      CREATE UNIQUE INDEX IF NOT EXISTS idx_eq_type_tr_on_eq_type_id_locale
        ON equipment_type_translations (equipment_type_id, locale);
    SQL
  end

  def down
    execute <<~SQL
      DROP INDEX IF EXISTS idx_eq_type_tr_on_eq_type_id_locale;

      CREATE UNIQUE INDEX IF NOT EXISTS index_equipment_type_translations_on_equipment_type_id_and_locale
        ON equipment_type_translations (equipment_type_id, locale);
    SQL
  end
end
