class CreateUsersAndUserSessions < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE users (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        email text NOT NULL,
        password_digest text NOT NULL,
        role character varying NOT NULL DEFAULT 'member',
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
      );

      CREATE UNIQUE INDEX index_users_on_lower_email ON users (lower(email));

      CREATE TABLE user_sessions (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        user_id uuid NOT NULL,
        ip_address text,
        user_agent text,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_user_sessions_users
          FOREIGN KEY (user_id)
          REFERENCES users (id)
          ON DELETE CASCADE
      );

      CREATE INDEX index_user_sessions_on_user_id ON user_sessions (user_id);
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE user_sessions;
      DROP TABLE users;
    SQL
  end
end
