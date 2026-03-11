class CreateBodyPartTranslations < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE body_part_translations (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        body_part_id uuid NOT NULL,
        locale character varying NOT NULL,
        name text NOT NULL,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_body_part_translations_body_parts
          FOREIGN KEY (body_part_id)
          REFERENCES body_parts (id)
          ON DELETE CASCADE
      );

      CREATE UNIQUE INDEX index_body_part_translations_on_body_part_id_and_locale
        ON body_part_translations (body_part_id, locale);
      CREATE INDEX index_body_part_translations_on_locale_and_lower_name
        ON body_part_translations (locale, lower(name));
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE body_part_translations;
    SQL
  end
end
