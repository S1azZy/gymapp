# Quality and Security

## Security baseline
Authentication:
- Passwords are hashed only (never plaintext)
- Never log passwords/tokens/secrets
- Password reset tokens must be single-use and time-bound
- Invalidate active sessions after password reset

Authorization:
- Policy checks on all user-owned resources
- Admin area protected by explicit admin policy
- Never trust client-provided ownership IDs

Sessions and transport:
- Secure, HttpOnly cookies
- Proper SameSite
- Production HTTPS (`force_ssl`) and proxy SSL handling (`assume_ssl`)
- CSRF protection enabled

Secrets and logging:
- No secrets in git
- Secrets only via env/credentials
- Filter sensitive parameters and headers

Abuse protection:
- Rate limit sign in
- Rate limit password reset
- Rate limit registration

## Testing strategy
Default stance:
- Integration-first with real PostgreSQL
- No mocks/stubs for app internals without strong reason
- Mocks/stubs acceptable mainly for external I/O boundaries
- Prefer `shared_context` / `shared_examples` when they reduce duplication clearly

Required spec layers:
- `spec/models`
- `spec/interactors`
- `spec/policies`
- `spec/requests`
- `spec/system`

Coverage policy:
- Global line coverage: `>= 90%`
- Critical business flows/interactors: `>= 95%`

Performance guardrails:
- Watch N+1 in changed areas
- Prefer focused and stable system tests

## CI and merge gates
Required checks:
- RuboCop
- Haml lint
- RSpec
- Brakeman
- bundler-audit

Before merge:
- All checks green
- Policy coverage for new secured flows
- I18n keys for `ru/en` added
- New business logic implemented via canonical yabi interactors
- New migrations follow SQL-only + `uuidv7()` rules
- `CHANGES.md` updated with a short dated summary
