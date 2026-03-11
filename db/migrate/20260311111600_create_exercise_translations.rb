class CreateExerciseTranslations < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE exercise_translations (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        exercise_id uuid NOT NULL,
        locale character varying NOT NULL,
        name text NOT NULL,
        description text,
        synonyms text[] NOT NULL DEFAULT '{}',
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_exercise_translations_exercises
          FOREIGN KEY (exercise_id)
          REFERENCES exercises (id)
          ON DELETE CASCADE
      );

      CREATE UNIQUE INDEX index_exercise_translations_on_exercise_id_and_locale
        ON exercise_translations (exercise_id, locale);
      CREATE INDEX index_exercise_translations_on_locale_and_lower_name
        ON exercise_translations (locale, lower(name));
      CREATE INDEX index_exercise_translations_on_synonyms
        ON exercise_translations
        USING gin (synonyms);
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE exercise_translations;
    SQL
  end
end
