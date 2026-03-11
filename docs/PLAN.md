# Plan

## Current status

Completed:
- Phase 0 bootstrap
- Phase 1 auth and app shell
- Phase 2 iteration 2.1: shared reference-data schema, models, and localized translation tables for the exercise catalog

In progress:
- Phase 2 iteration 2.2: admin CRUD, seed baseline catalog, and user-facing catalog browsing surfaces

## MVP baseline

The MVP must cover the baseline users expect from mainstream workout trackers before any differentiated features:
- Auth, locale switch, protected app shell, and admin access gate
- Shared exercise catalog with localized names/synonyms, search, and filtering
- Workout templates with ordered exercises
- Workout sessions separate from templates
- Start workout from template or scratch
- Draft save/resume/discard workflow
- Add/edit/remove exercises and sets during a workout
- Rest timer plus previous-result / last-weight hints
- Workout notes and wellbeing score `1..5`
- History list, calendar, and completed workout detail view
- Best set, PR markers, estimated `1RM`, and simple charts

## Delivery phases

### Phase 0: bootstrap [completed]
- Rails + PostgreSQL + Docker/compose
- Hotwire + Tailwind + Haml
- SQL-only migration workflow (`structure.sql`, `uuidv7()` PK)
- RSpec + SimpleCov + test-prof
- RuboCop + Brakeman + bundler-audit
- CI baseline

### Phase 1: auth and app shell [completed]
- Registration/login/logout
- Password reset
- Roles and admin access gate
- Base layouts/navigation
- Locale switch (`ru`/`en`)

### Phase 2: reference data
#### Iteration 2.1 [completed]
- Reference-data schema for exercises, classifications, tags, and translation tables
- Shared models, factories, and model specs
- SQL-only migrations with UUIDv7/FK/index constraints

#### Iteration 2.2 [next]
- Admin CRUD for reference data
- Seed baseline catalog
- User-facing exercise catalog browsing
- Search and filtering by classification/tag

#### Iteration 2.3 [next]
- Exercise picker UX for templates and workout logging
- Localized synonym matching in catalog search
- Reference-data policy coverage and request/system specs

### Phase 3: templates and planning
#### Iteration 3.1
- Workout template CRUD
- Ordered template exercises
- Template detail screen optimized for mobile

#### Iteration 3.2
- Start workout from template
- Preserve plan snapshot boundaries required for later plan-vs-fact comparison
- Request/spec coverage for template authoring flows

### Phase 4: core workout execution
#### Iteration 4.1
- Start workout from scratch
- Add/edit/remove exercises and sets
- Save draft automatically
- Resume and discard draft safely

#### Iteration 4.2
- Complete workout
- Completed workout detail screen
- Workout notes
- Wellbeing score `1..5`

#### Iteration 4.3
- Rest timer
- Previous-result / last-weight helper
- Fast mobile-first logging interactions

### Phase 5: history and statistics
#### Iteration 5.1
- History list and calendar
- Drill down into completed workout details
- Stable session facts independent of later template edits

#### Iteration 5.2
- Best set and PR markers
- Estimated `1RM`
- Basic progress charts

#### Iteration 5.3
- Explicit plan-vs-fact presentation built from workout-session facts
- Basic adherence summaries for templates vs completed sessions

### Phase 6: hardening and release readiness
- Security and policy review
- Mobile UX polish
- Performance checks
- Seed/demo data and deploy docs
- Final MVP verification against the baseline checklist above

## Post-MVP roadmap
- v1.1: user exercise extensions, improved stats, better filtering/search, supersets
- v1.2: progression suggestions, equipment-aware substitutions, bodyweight/measurement tracking
- v1.3: coach/shared planning and review flows

## Parking lot
- Social login
- AI analysis/advice
- Text-to-workout parsing
- Telegram ingestion
- Optional Hotwire Native wrapper

## Rule
No parking-lot work before the full MVP baseline and core workout loop are complete.
