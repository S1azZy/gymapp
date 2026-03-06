You are bootstrapping a new production-minded Rails application called **Gym App**.

Read and follow these project files first:
- `AGENTS.md`
- `docs/PRODUCT_REQUIREMENTS.md`
- `docs/ARCHITECTURE.md`
- `docs/DOMAIN_MODEL.md`
- `docs/SECURITY.md`
- `docs/TESTING_STRATEGY.md`
- `docs/ROADMAP.md`
- `docs/IMPLEMENTATION_PLAN.md`
- `docs/TECH_DECISIONS.md`

This is a real product-first project. Learning modern Rails stack is a valuable secondary benefit, but not the primary goal.
Choose technologies and implementation details that maximize product quality, maintainability, and coherence.

Your task is to create the initial repository scaffold for the MVP.

## Mandatory stack
- Ruby 4+ target; until Ruby 4 stable GA use latest stable Ruby 3.4.x
- Rails 8.1.x (latest stable patch)
- PostgreSQL 18.3 (or latest stable 18.x patch)
- Hotwire (Turbo + Stimulus)
- Tailwind CSS
- Docker and docker-compose
- Kamal config placeholders
- RSpec
- RuboCop
- Brakeman
- bundler-audit
- SimpleCov
- I18n: ru + en
- `yabi` gem for the canonical interactor/use-case style

## Architectural constraints
- Rails monolith
- mobile-first responsive UI
- thin controllers
- thin models
- business use cases implemented through one consistent yabi-based interactor style
- authorization via policies
- shared exercise catalog
- workout templates and workout sessions must be separate concepts
- statistics must live in a separate module/namespace
- no AI in MVP
- no Telegram bot in MVP
- no SPA frontend
- project-wide consistency is mandatory

## Deliverables for the initial scaffold
1. Rails application skeleton.
2. Authentication setup for email/password with secure password handling.
3. Authorization layer.
4. Admin area scaffold.
5. Base layouts and navigation.
6. Locale infrastructure for Russian and English.
7. Docker / compose files for development.
8. CI workflow.
9. Lint/test/security tooling.
10. Seed structure for future shared exercise catalog.
11. Placeholder namespaces/modules for:
   - reference data
   - workout templates
   - workout execution
   - statistics
   - admin
12. Canonical interactor base pattern and example yabi-based interactors.

## Coding expectations
- prefer official Rails conventions
- choose boring, stable dependencies
- explain any non-obvious gem choice
- generate tests for critical flows and interactors
- set coverage threshold
- filter sensitive params
- configure production-safe defaults where reasonable
- keep style uniform across the generated project

## First implementation step
First, generate the project structure and configuration files only.
Do not fully implement all domain models at once.
After bootstrap, propose the next small vertical slice: auth + base app shell.
