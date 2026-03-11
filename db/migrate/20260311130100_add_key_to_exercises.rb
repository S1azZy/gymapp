class AddKeyToExercises < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      ALTER TABLE exercises
      ADD COLUMN key text;

      UPDATE exercises
      SET key = 'exercise_' || substr(replace(id::text, '-', ''), 1, 12)
      WHERE key IS NULL;

      ALTER TABLE exercises
      ALTER COLUMN key SET NOT NULL;

      CREATE UNIQUE INDEX index_exercises_on_key ON exercises (key);
    SQL
  end

  def down
    execute <<~SQL
      DROP INDEX index_exercises_on_key;
      ALTER TABLE exercises DROP COLUMN key;
    SQL
  end
end
