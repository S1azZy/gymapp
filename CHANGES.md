# Changes

## 2026-03-06

- Created the initial Gym App Rails scaffold with Docker-based local development and a minimal home page.
- Added a dated project change log, a branch-and-PR workflow rule set, Docker-oriented `make` commands, and local pre-commit verification with RuboCop and tests.
- Added project-wide rules for SQL-only migrations, PostgreSQL 18 `uuidv7()` primary keys, strict relational constraints, and integration-first testing with `test-prof`.
- Moved migration guidance into `docs`, clarified that business validations stay in the application layer, and switched view templates from ERB to Haml.
