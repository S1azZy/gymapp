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
- Shared exercise catalog with classifications (body part, muscle group, equipment, tags)
- Workout templates (reusable plans with ordered exercises)
- Workout sessions (real execution, separate from templates)
- Plan vs fact flow, draft workouts, set logging (weight/reps)
- Rest timer and last-weight hint
- Wellbeing score 1..5 per workout
- History calendar
- Statistics: best set, estimated 1RM, basic charts
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
- `BodyPart`, `MuscleGroup`, `Equipment`, `Tag`
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
- Required constraints: `NOT NULL`, `FOREIGN KEY`, indexes as needed
- `CHECK` only for true storage-level invariants
- Business validation belongs to app layer
- No triggers/stored procedures/extensions unless explicitly approved

## Consistency contract
- Do not mix multiple interactor styles
- Do not mix multiple authorization styles
- Keep naming/placement conventions uniform
- Avoid one-off local patterns that break project coherence
