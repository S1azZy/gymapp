# Plan

## Delivery phases

### Phase 0: bootstrap
- Rails + PostgreSQL + Docker/compose
- Hotwire + Tailwind + Haml
- SQL-only migration workflow (`structure.sql`, `uuidv7()` PK)
- RSpec + SimpleCov + test-prof
- RuboCop + Brakeman + bundler-audit
- CI baseline

### Phase 1: auth and app shell
- Registration/login/logout
- Password reset
- Roles and admin access gate
- Base layouts/navigation
- Locale switch (`ru`/`en`)

### Phase 2: reference data
- Exercise catalog + classifications + tags
- Admin CRUD for reference data
- Seed baseline catalog

### Phase 3: templates
- Workout template CRUD
- Ordered template exercises

### Phase 4: workout execution
- Start from template or scratch
- Draft workflow
- Add/edit/remove exercises and sets
- Rest timer + last-weight helper
- Complete workout

### Phase 5: history and statistics
- History and calendar
- Best set and estimated 1RM
- Progress charts

### Phase 6: hardening
- Security and policy review
- Mobile UX polish
- Performance checks
- Seed/demo data and deploy docs

## Post-MVP roadmap
- v1.1: Google/Apple login, improved stats, user exercise extensions, better filtering/search
- v1.2: AI analysis/advice, text-to-workout parsing
- v1.3: Telegram ingestion
- v1.4: Optional Hotwire Native wrapper

## Rule
No AI, Telegram, or native wrapper work before core workout loop is complete.
