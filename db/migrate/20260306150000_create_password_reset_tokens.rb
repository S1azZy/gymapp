class CreatePasswordResetTokens < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE password_reset_tokens (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        user_id uuid NOT NULL,
        token_digest character varying NOT NULL,
        expires_at timestamp(6) without time zone NOT NULL,
        used_at timestamp(6) without time zone,
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_password_reset_tokens_users
          FOREIGN KEY (user_id)
          REFERENCES users (id)
          ON DELETE CASCADE
      );

      CREATE UNIQUE INDEX index_password_reset_tokens_on_token_digest
        ON password_reset_tokens (token_digest);

      CREATE INDEX index_password_reset_tokens_on_user_id
        ON password_reset_tokens (user_id);
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE password_reset_tokens;
    SQL
  end
end
