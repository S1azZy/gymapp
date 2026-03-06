# Tech Decisions

## Decision framing

This project is product-first.
Technology choices should optimize for:
1. product fit
2. maintainability
3. consistency
4. delivery speed
5. learning value

Learning modern Rails stack is a real goal, but it is secondary.

## Chosen stack

### Backend
- Ruby 4+ target; until Ruby 4 stable GA use latest stable Ruby 3.4.x
- Rails 8.1.x (latest stable patch)
- PostgreSQL 18.3 (or latest stable 18.x patch)
- Active Record

### Frontend
- server-rendered HTML
- Hotwire: Turbo + Stimulus
- Tailwind CSS
- mobile-first responsive UI

### Use-case layer
- `yabi` gem as the canonical interactor abstraction
- one unified calling style across the project
- interactors handle orchestration, not persistence details

### Authorization
- Pundit by default

### Admin
- simple namespaced admin or ActiveAdmin
- choose one and keep it consistent

### Infra
- Docker + docker-compose for development
- Kamal for deployment readiness
- VPS-friendly deployment model

### Quality
- RSpec
- RuboCop
- Brakeman
- bundler-audit
- SimpleCov

## Deliberate non-decisions / anti-goals

### No SPA frontend for MVP
A SPA would increase complexity without clear product benefit for this scope.

### No API-first split for MVP
A separate frontend/backend architecture is unnecessary at this stage.

### No repository layer at the start
Repositories may be introduced later if complexity demands them.
They are not part of the starting architecture.

### No dry-stack by default
Dry gems may be considered surgically later, but they are not a baseline requirement.

### No multiple business-logic styles
Do not mix free-form services, command objects, random POROs, and interactors without discipline.
The canonical pattern is yabi-based interactors.

## Version policy

- Prefer latest stable patch versions by default.
- Prefer latest stable major only after dependency and tooling compatibility check.
- Security and supportability are higher priority than adopting prerelease versions.

## Why Hotwire/Tailwind/Kamal are included

These technologies are current and practical in the Rails ecosystem, but they are included because they fit the project:
- Hotwire matches CRUD-heavy and form-heavy product flows
- Tailwind speeds up coherent UI development with limited frontend overhead
- Kamal matches a simple VPS-oriented deployment story for a Rails monolith

## Codebase consistency rules

### Interactors
- keep one base convention
- keep one result contract
- keep one naming style
- keep one testing style

### Controllers
- delegate orchestration
- keep authorization explicit
- do not accumulate business logic

### Models
- own persistence and local invariants
- stay relatively thin
- avoid callback-heavy orchestration

### Views/UI
- use a consistent composition approach
- reuse form partials/components systematically
- prefer clarity over clever UI abstractions

### Tests
- same style of spec organization across modules
- same naming conventions across spec types
- explicit coverage for interactors, policies, and key user flows

## Upgrade path

- MVP web app
- social login
- AI analysis module
- Telegram ingestion
- optional Hotwire Native wrapper
