# Changes

## 2026-03-06

- Created the initial Gym App Rails scaffold with Docker-based local development and a minimal home page.
- Added a dated project change log, a branch-and-PR workflow rule set, Docker-oriented `make` commands, and local pre-commit verification with RuboCop and tests.
- Added project-wide rules for SQL-only migrations, PostgreSQL 18 `uuidv7()` primary keys, strict relational constraints, and integration-first testing with `test-prof`.
- Moved migration guidance into `docs`, clarified that business validations stay in the application layer, and switched view templates from ERB to Haml.
- Bootstrapped the phase 2 engineering stack with RSpec, SimpleCov, FactoryBot, Shoulda Matchers, Pundit, yabi, bcrypt, and an RSpec-based verification flow.
- Added the auth foundation: SQL-backed `users` and `user_sessions`, session-based sign-in/sign-out, `Current`, a protected dashboard, and yabi-based session authentication interactor coverage.
- Updated workflow rules so RuboCop runs with autocorrect by default and test conventions explicitly encourage shared RSpec contexts/examples where they improve clarity.
- Added sign-up flow with yabi-based user creation, automatic sign-in after registration, localized Haml pages, and full request/interactor coverage.
- Added password reset request and completion flows with mail delivery, single-use reset tokens, session invalidation, localized Haml pages, and integration-heavy RSpec coverage.
- Completed phase 2 with session-persisted `ru/en` locale switching, Pundit policies, admin access gate, cache-backed auth rate limiting, localized app shell navigation, and request/policy/system test coverage.
- Tightened the project scaffold with a stronger `make verify`, `verify-fast` and `doctor` commands, Haml lint in CI, `.editorconfig`, `.gitattributes`, a PR template, and cleaner git/docker ignore rules.
- Added scaffold completion polish: README badges, real Hotwire importmap runtime wiring, Tailwind Rails integration, Kamal deploy placeholder config, and production SSL defaults.

## 2026-03-11

- Consolidated documentation from 9 files to 3 focused files: `docs/FOUNDATIONS.md`, `docs/QUALITY_SECURITY.md`, and `docs/PLAN.md`.
- Removed duplicated/verbose docs sections and kept only hard project rules, quality/security gates, and delivery plan.
- Updated `AGENTS.md`, `README.md`, and `templates/CODEX_BOOTSTRAP_PROMPT.md` to reference the new docs structure.
- Started Phase 2 (iteration 2.1): added reference-data schema and models for the shared exercise catalog with SQL-only migrations (1 file per table), strict UUIDv7/FK/index rules, factories, and model-level RSpec coverage.
- Standardized localization storage for dynamic catalog/reference data via per-entity translation tables (`*_translations`), including exercise synonyms stored per locale.
- Refined the canonical MVP roadmap around the current `main` branch state: marked completed phases, split the remaining work into smaller baseline-first iterations, and promoted missing must-have workout-tracker features into the plan and foundations docs.
- Added persistent locale preferences: authenticated users now store `preferred_locale` in `users`, guests use a signed cookie, and locale resolution now falls back through params, user preference, cookie, `Accept-Language`, and then the app default.
- Added admin CRUD for localized reference data (`body_parts`, `muscle_groups`, `equipment_types`, `tags`) with a shared Rails admin UI, yabi-based persistence interactors, and request coverage for admin/member/guest access.
- Added admin exercise CRUD with localized `name/description/synonyms`, classification links, tag assignment, and yabi-based persistence covered by request and interactor specs.
- Hardened catalog schema for idempotent seeds and admin UX with stable `key` identifiers, sortable `position` fields, and baseline reference/exercise seeds built entirely on keys rather than translated names.
