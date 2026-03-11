class CreateMuscleGroupTranslations < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE muscle_group_translations (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        muscle_group_id uuid NOT NULL,
        locale character varying NOT NULL,
        name text NOT NULL,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_muscle_group_translations_muscle_groups
          FOREIGN KEY (muscle_group_id)
          REFERENCES muscle_groups (id)
          ON DELETE CASCADE
      );

      CREATE UNIQUE INDEX index_muscle_group_translations_on_muscle_group_id_and_locale
        ON muscle_group_translations (muscle_group_id, locale);
      CREATE INDEX index_muscle_group_translations_on_locale_and_lower_name
        ON muscle_group_translations (locale, lower(name));
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE muscle_group_translations;
    SQL
  end
end
