# Foundations

## Product priorities
Decision order:
1. Product value
2. Maintainability and consistency
3. Delivery speed
4. Learning value

Gym App is a production-minded, mobile-first training tracker.

## MVP scope
Must-have:
- Email/password auth: sign up, sign in/out, password reset
- Shared exercise catalog with classifications (body part, muscle group, equipment, tags), localized names/synonyms, and browse/search/filter flows
- Workout templates (reusable plans with ordered exercises)
- Workout sessions (real execution, separate from templates, with workout facts preserved if templates change later)
- Plan vs fact flow, draft workouts with resume/discard, set logging (weight/reps), and simple workout notes
- Rest timer and last-weight / previous-performance hint
- Wellbeing score 1..5 per workout
- History calendar and completed workout detail screen
- Statistics: best set, PR markers, estimated 1RM, basic charts
- Admin area
- RU/EN localization from day one

Explicitly out of MVP:
- AI features
- Telegram bot
- Social login
- Offline-first sync
- Attachments/uploads
- Advanced planning calendar

## Stack
Mandatory:
- Ruby target `4+` (until GA: latest stable `3.4.x`)
- Rails `8.1.x` latest stable patch
- PostgreSQL `18.x` latest stable patch
- Hotwire (`Turbo + Stimulus`)
- Tailwind CSS
- Haml templates
- Docker + docker-compose
- Kamal placeholders
- RSpec + SimpleCov + test-prof
- RuboCop + Brakeman + bundler-audit
- `yabi` as canonical interactor/use-case layer
- Pundit authorization
- I18n locales: `ru`, `en`

## Architecture
- Rails monolith, server-rendered, mobile-first
- Thin controllers (HTTP orchestration only)
- Thin models (persistence + local invariants)
- Business orchestration only in `app/interactors` via one yabi style
- Explicit authorization via policies
- Statistics as separate module/namespace

Bounded areas:
- Identity
- ReferenceData
- WorkoutTemplates
- WorkoutExecution
- Statistics
- Admin

Hard boundaries:
- Template and session are different entities
- Workout templates are user-owned; shared reference data remains global/admin-managed
- User-authored template names and notes use plain fields, not translation tables
- Session facts must remain valid if template changes later
- Statistics read workout facts and do not mutate logging flow

## Domain skeleton
Core entities:
- `User`
- `Exercise`
- `WorkoutTemplate`
- `WorkoutTemplateExercise`
- `WorkoutSession`
- `WorkoutSessionExercise`
- `SetEntry`

Reference data:
- `BodyPart`, `MuscleGroup`, `EquipmentType`, `Tag`
- enum allowed for small stable sets
- reference tables preferred when metadata/admin/extensibility are required

## Database and migration rules
- SQL-only migrations inside Rails migration wrappers
- Only explicit `up` / `down`
- Only `execute <<~SQL` for schema changes
- No AR migration DSL (`create_table`, `add_column`, `change`, etc.)
- Canonical dump: `structure.sql`
- Every PK: `uuid PRIMARY KEY DEFAULT uuidv7()`
- Explicit foreign keys and indexes
- Keep all index names within PostgreSQL identifier limit (`<= 63` chars)
- Required constraints: `NOT NULL`, `FOREIGN KEY`, indexes as needed
- `CHECK` only for true storage-level invariants
- Business validation belongs to app layer
- No triggers/stored procedures/extensions unless explicitly approved
- Dynamic localized reference/catalog data must use base tables plus per-entity `*_translations` tables (no locale-specific columns in base tables).
- Every dynamic reference/catalog entity must have an immutable `key` used for seeds, imports, lookups, and relations to seeded data; translations must never be used as identifiers.

## Consistency contract
- Do not mix multiple interactor styles
- Do not mix multiple authorization styles
- Keep naming/placement conventions uniform
- Avoid one-off local patterns that break project coherence
