# Architecture

## Architectural goals

1. Build a real, maintainable product first.
2. Keep the codebase cohesive and internally consistent.
3. Use modern Rails full-stack tools where they clearly improve the project.
4. Avoid enterprise-style abstraction layers that do not pay for themselves in this codebase.
5. Leave clear extension points for future AI ingestion, Telegram ingestion, and social login.

## Recommended approach

Use a **Rails 8.1 monolith** with a mobile-first server-rendered UI.

### Why this is the best fit

- Strong match for the product scope.
- Fastest path to a real MVP.
- Lower complexity than SPA + API + separate mobile apps.
- Good compatibility with a later Hotwire Native wrapper.
- Easier to test end-to-end.
- Lets the project stay coherent across backend, frontend, and deployment.

## High-level modules

### 1. Identity & Access
- registration
- login/logout
- password reset
- account roles
- admin access

### 2. Reference Data
- exercise catalog
- body parts
- muscle groups
- equipment
- tags

### 3. Workout Templates
- template lifecycle
- ordered template exercises

### 4. Workout Execution
- workout session start
- draft state
- completion state
- planned vs actual tracking
- sets logging
- rest timer support at UI level

### 5. Progress & Statistics
- best set per exercise
- estimated 1RM
- chart data providers
- calendar history aggregation

### 6. Admin
- manage shared catalog
- manage users
- basic moderation / support functions

## Suggested Rails structure

- `app/controllers` — thin HTTP orchestration only
- `app/models` — persistence and lightweight domain rules
- `app/interactors` — canonical business use-case layer implemented with `yabi`
- `app/policies` — authorization rules
- `app/presenters` or `app/view_models` — UI-specific formatting where needed
- `app/javascript/controllers` — Stimulus behavior

## Use-case / interactor philosophy

Use `yabi` as the standard way to model business use cases.
This is not meant to replace Rails architecture with a separate framework.
It is meant to standardize the orchestration layer.

Rules:
- one project-wide interactor style
- one project-wide argument passing style
- one project-wide result handling style
- thin controllers delegate to interactors
- interactors orchestrate model operations and side effects
- models keep persistence logic and local invariants
- authorization stays explicit, not hidden in model callbacks

Avoid mixing:
- ad hoc service objects
- interactors with incompatible calling conventions
- controller-heavy orchestration
- multiple parallel ways to encode business flows

## Domain boundaries

### Workout template
A reusable plan. It is not the source of truth for what actually happened.

### Workout session
A real training event. It may originate from a template but stores actual performed data independently.

### Statistics module
Consumes workout facts and exposes computed metrics. It must not own workout entry flows.

## Persistence philosophy

- Use Active Record.
- Use raw SQL migrations managed by Rails migration files.
- Store schema in `structure.sql`.
- Use PostgreSQL 18 `uuidv7()` for all primary keys.
- Start without a repository layer.
- Introduce query/repository abstractions only where complexity clearly justifies them.
- Prefer inspectable Rails patterns.
- Keep models thin.
- Keep database design strict with explicit foreign keys and indexes.
- Keep business rules in the application layer; only use database `CHECK` constraints for persistence-level invariants that clearly belong in storage.
- Avoid triggers and database-side automation in MVP unless a later decision explicitly allows them.

## Admin approach

Prefer one of these, in order:
1. Rails namespaced admin UI if simple and controllable.
2. ActiveAdmin if speed of delivery wins.
3. Avo only after confirming license / feature fit.

Recommendation for MVP: **simple namespaced admin or ActiveAdmin**, depending on the final tradeoff between control and speed.

## Frontend approach

- Turbo Drive / Turbo Frames for navigation and partial updates
- Stimulus for small interactive behaviors
- Tailwind CSS for styling
- mobile-first responsive layout from day one
- no SPA framework for MVP

## Mobile approach

### Phase 1
Mobile-first responsive web app.

### Phase 2
Optional Hotwire Native shell for iOS/Android if web UX proves good enough.

## Background processing

Prefer built-in Rails-friendly options first.

Candidates:
- Solid Queue for future async work
- Sidekiq only if background workload later becomes more serious

For MVP, background jobs should be minimal.

## Observability

- structured request logs
- error tracking integration placeholder
- audit important admin actions
- health endpoint for deployment

## Coherence requirements

The project must feel like one system, not a collection of unrelated patterns.

This applies to:
- naming conventions
- file organization
- interactor structure
- authorization style
- test style
- UI composition
- error handling
- localization conventions

When a project-level decision is made, it should be documented and followed across the codebase.

## Evolution path

MVP web app -> production hardening -> social login -> AI insights -> Telegram ingestion -> optional Hotwire Native shell
