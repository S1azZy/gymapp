class CreateTagTranslations < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE tag_translations (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        tag_id uuid NOT NULL,
        locale character varying NOT NULL,
        name text NOT NULL,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_tag_translations_tags
          FOREIGN KEY (tag_id)
          REFERENCES tags (id)
          ON DELETE CASCADE
      );

      CREATE UNIQUE INDEX index_tag_translations_on_tag_id_and_locale
        ON tag_translations (tag_id, locale);
      CREATE INDEX index_tag_translations_on_locale_and_lower_name
        ON tag_translations (locale, lower(name));
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE tag_translations;
    SQL
  end
end
