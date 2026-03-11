class AddPreferredLocaleToUsers < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      ALTER TABLE users
      ADD COLUMN preferred_locale character varying NOT NULL DEFAULT 'en';
    SQL
  end

  def down
    execute <<~SQL
      ALTER TABLE users
      DROP COLUMN preferred_locale;
    SQL
  end
end
