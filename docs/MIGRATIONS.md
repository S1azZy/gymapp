# Database Migration Rules

This project uses Rails migration files only as wrappers around raw SQL.

## Required rules

- Use explicit `up` and `down`.
- Write schema changes with `execute <<~SQL`.
- Do not use Active Record migration DSL such as `create_table`, `add_column`, `add_reference`, or `change`.
- Use `uuid` primary keys with `DEFAULT uuidv7()`.
- Add foreign keys and indexes explicitly in SQL.
- Prefer strict structural constraints such as `NOT NULL`, `FOREIGN KEY`, and indexes.
- Use `CHECK` constraints only for true storage-level invariants, not for business validations that belong in the application layer.
- Do not add triggers, stored procedures, or PostgreSQL extensions unless explicitly approved.
- Enums are allowed; use reference tables instead when values need metadata, administration, or future extension.

## Example

```ruby
class CreateUsers < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE TABLE users (
        id uuid PRIMARY KEY DEFAULT uuidv7(),
        email text NOT NULL,
        password_digest text NOT NULL,
        role text NOT NULL DEFAULT 'member',
        created_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
      );

      CREATE UNIQUE INDEX index_users_on_email ON users (lower(email));
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE users;
    SQL
  end
end
```
