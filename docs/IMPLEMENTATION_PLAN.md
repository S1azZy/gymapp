# Implementation Plan

## Phase 0 — project bootstrap

- generate Rails 8.1 app with PostgreSQL 18.3
- add Docker / docker-compose
- add RSpec, FactoryBot, SimpleCov
- add RuboCop, Brakeman, bundler-audit
- configure CI
- configure Tailwind, Hotwire, locales
- choose authorization and admin approach

## Phase 1 — auth and access control

- user registration/login/logout
- password reset
- roles/admin gate
- base layouts and navigation
- locale switcher

## Phase 2 — reference data

- exercise catalog
- classifications and tags
- admin management for reference data
- seed initial catalog

## Phase 3 — templates

- create/edit/delete workout templates
- order exercises in template
- template list/detail pages

## Phase 4 — workout execution

- start from template or from scratch
- workout draft flow
- add/edit/remove performed exercises
- add/edit/remove sets
- rest timer UI
- last-weight autofill
- complete workout

## Phase 5 — history and statistics

- history list
- calendar view
- chart pages
- best set calculation
- estimated 1RM calculation

## Phase 6 — hardening

- security review
- policy coverage review
- UI polish on phone
- performance checks
- seed/demo data
- deployment docs and Kamal config

## Notes

Do not start with AI, Telegram, or native wrappers. Get the workout loop excellent first.
