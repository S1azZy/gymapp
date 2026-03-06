# Testing Strategy

## Testing philosophy

Use a full test pyramid with emphasis on correctness of business logic and critical user flows.

## Test stack

- RSpec
- test-prof
- Capybara system specs
- FactoryBot
- Shoulda Matchers where useful
- SimpleCov with threshold

## Default testing stance

- Prefer integration tests with the real database.
- Do not mock or stub application code unless there is deep need, typically at external service boundaries.
- Persistence-heavy business logic should be exercised end-to-end against the database.
- Use test-prof guidance to keep factories, setup cost, and slow examples under control.

## Database testing stance

- Test SQL migrations and persistence behavior through the real database.
- Do not replace database behavior with stubs or fake repositories.

## Layers

### 1. Model specs
Test validations, associations, small domain invariants.

### 2. Service specs
Primary location for business logic verification.

Examples:
- create workout from template
- save draft workout
- complete workout session
- compute best set
- compute estimated 1RM

### 3. Policy specs
Every secured domain area should have policy coverage.

### 4. Request specs
Critical HTTP behavior:
- authentication flows
- admin authorization
- CRUD entry points
- locale switching if applicable

### 5. System specs
End-to-end flows on the web UI:
- sign up / sign in
- create template
- start workout from template
- log performed sets
- complete workout
- view stats

## Coverage policy

- SimpleCov enabled in test suite
- global threshold: 90% line coverage target for application code introduced in MVP
- critical business services target: 95%+
- do not chase meaningless coverage on trivial generated code

## What must be tested first

1. authentication and authorization
2. workout creation/editing/completion flows
3. plan vs fact behavior
4. statistics calculations
5. admin access rules

## CI gates

Required:
- bundle exec rubocop
- bundle exec rspec
- bundle exec brakeman -q -w2
- bundle exec bundle-audit check --update

## Performance / regression concerns

- watch for N+1 queries in stats and history pages
- prefer focused request/system specs over brittle excessive UI coverage
- test service objects thoroughly to keep refactors safe
