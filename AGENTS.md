# AGENTS.md

## Project identity

Project: Gym App
Type: Rails monolith, mobile-first web app
Primary audience: small number of authenticated users, later expandable to a multi-user SaaS
Primary objective: build a real, maintainable product
Secondary objective: learn and practice current Rails full-stack technologies while shipping the product

## Mission

Build a production-minded training tracker with:
- shared exercise catalog
- rich exercise classification
- workout templates
- real workout logging
- plan vs fact workflow
- sets with weights/reps
- draft workout session editing
- rest timer
- simple wellbeing tracking (1..5)
- history calendar
- statistics module
- admin panel
- bilingual UI (ru/en)

## Product-first rule

When there is tension between:
- educational novelty
- implementation elegance
- product value
- long-term maintainability

prioritize in this order:
1. product value
2. maintainability and consistency
3. delivery speed
4. educational value

Do not introduce technology only because it is fashionable.
Use modern Rails stack where it provides clear benefit to this project.

## Non-goals for MVP

Do NOT implement in MVP:
- AI features
- Telegram bot
- social login
- offline-first sync engine
- file uploads
- advanced program generation
- complex planning calendar
- wearable integrations

## Stack requirements

Mandatory:
- Ruby 4+ target; until Ruby 4 stable GA use latest stable Ruby 3.4.x
- Rails 8.1.x (latest stable patch)
- PostgreSQL 18.3 (or latest stable 18.x patch)
- Hotwire (Turbo + Stimulus)
- Tailwind CSS
- Docker and docker-compose for development
- Kamal config placeholders for deployment
- RSpec
- `yabi` gem for use-case / interactor style service objects
- Pundit or Action Policy for authorization
- Active Storage disabled unless later needed
- I18n with Russian and English locales from day one

Preferred libraries / tools
- authentication: Rails built-in auth generator OR Devise only if justified; default to Rails built-in auth unless there is a concrete blocker
- authorization: Pundit
- admin: ActiveAdmin or Avo Community if licensing and complexity are acceptable; otherwise Rails namespace admin UI
- forms: standard Rails forms + form objects where needed
- charts: Chartkick + Groupdate or another simple server-friendly charting stack
- pagination: Pagy
- enums/state: plain Rails enum unless a stronger case exists
- background jobs: Solid Queue or Sidekiq only if clearly needed; prefer built-in first for MVP
- rate limiting / abuse protection: use Rails-native options where possible

## Architectural rules

1. Keep controllers thin.
2. Keep models thin; models own persistence concerns and local invariants, not orchestration.
3. Business use cases live in service/interactor objects under `app/interactors` or another single agreed directory, implemented consistently with `yabi`.
4. Choose one canonical interactor style and use it everywhere in the project.
5. Authorization is explicit and centralized.
6. Query complexity stays small; do not add repositories/query objects prematurely unless complexity justifies it.
7. Statistics lives in a separate bounded module/namespace so metrics can be extended without contaminating core logging flows.
8. Workout template and workout execution are separate concepts.
9. Shared reference data must be modeled so future per-user extensions are possible.
10. Avoid overengineering and speculative abstraction.
11. Project-wide consistency is a hard requirement: naming, service patterns, testing style, UI conventions, and authorization patterns must be uniform.

## Consistency rules

- Do not mix multiple service object styles.
- Do not mix multiple authorization approaches.
- Do not mix multiple UI composition approaches without a documented decision.
- Do not introduce local one-off patterns when a project pattern already exists.
- New code must follow the same file placement and naming conventions as existing code.
- If a new abstraction is introduced, document it and apply it consistently from that point on.

## Security rules

1. Never store plaintext passwords.
2. Never log passwords, tokens, secrets, or raw credentials.
3. Use secure password hashing provided by Rails.
4. All secrets via environment variables / credentials only.
5. CSRF protection enabled.
6. Strong session/cookie settings.
7. Authorization checks required on every user-owned resource.
8. Admin area fully isolated by role checks.
9. Brakeman, bundler-audit, RuboCop, RSpec must run in CI.
10. Coverage threshold required.

## Quality gates

Before any merge:
- tests pass
- linters pass
- security scans pass
- no obvious N+1 in changed areas
- i18n keys added for ru/en
- policy coverage added for new secured flows
- new business logic implemented through the canonical interactor pattern
- new code matches established architectural conventions
- `CHANGES.md` updated with a short dated summary of user-visible or workflow-relevant changes

## Git workflow

- All changes must be made in a dedicated branch.
- Branch names created by Codex must use the `codex/` prefix.
- Changes are merged through GitHub Pull Requests, not direct commits to `main`.
- Before opening or updating a PR, run the local verification flow and ensure it is green.

## Coding style

- Favor readability over cleverness.
- Prefer explicit names.
- Keep methods short.
- Avoid hidden side effects.
- Avoid fat helpers.
- Prefer boring, inspectable Rails patterns.
- Use POROs for business operations.
- Add YARD-style docs only where complexity justifies it.

## Directory expectations

- `app/interactors` or another single chosen directory for yabi-based use cases
- `app/policies`
- `app/presenters` or `app/view_models` if needed
- `app/components` only if a component system is introduced intentionally and documented
- `spec/requests`
- `spec/system`
- `spec/interactors` or the matching spec directory for the chosen use-case layer
- `spec/policies`
- `spec/models`

## Agent behavior

When generating code:
- prefer stable, boring solutions
- prefer official Rails conventions over exotic gems
- explain tradeoffs when introducing dependencies
- do not invent undocumented requirements
- if uncertain, implement the smallest safe and testable solution
- preserve project coherence even when a different local solution might also work
- keep `CHANGES.md` current by appending a concise dated summary for each completed step
