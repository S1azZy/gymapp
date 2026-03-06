# Security Requirements

## Security posture

This project must be treated as a security-conscious production app from day one, even if the first user count is tiny.

## Authentication

- Email + password in MVP.
- Passwords must be hashed using Rails secure password/auth system.
- Plaintext passwords must never be stored.
- Plaintext passwords must never be logged.
- Password reset tokens must be time-bound and single-use.
- Session invalidation flows should exist for password reset / account recovery scenarios.

## Authorization

- Every user-owned resource must be protected by policy checks.
- Admin area must be protected by explicit admin authorization.
- No trusting client-submitted user IDs for ownership decisions.

## Sessions and cookies

- Secure, HttpOnly cookies.
- SameSite configured appropriately.
- Force SSL in production.
- Strict session expiration strategy documented.

## Secrets

- No secrets in git.
- Use environment variables and/or Rails credentials.
- Separate credentials for development, staging, production.
- Rotate secrets when compromised or suspected compromised.

## Input handling

- Strong parameters everywhere.
- Validate uploaded / imported content if later introduced.
- Escape/render content safely in views.
- Sanitize rich text only if rich text is introduced later.

## Logging and privacy

- Filter sensitive parameters.
- Never log passwords, reset tokens, session tokens, auth headers.
- Keep logs useful but non-sensitive.

## Dependencies and security scanning

Required in CI:
- Brakeman
- bundler-audit
- dependency review if available in CI platform

## Admin security

- Separate admin namespace.
- Audit important admin actions.
- Consider additional admin session timeout if easy to implement.

## Rate limiting and abuse protection

Minimum requirements:
- login endpoint protection
- password reset endpoint protection
- registration endpoint protection

## Transport security

- HTTPS only in production.
- Secure proxy / deployment configuration.
- Security headers enabled.

## Future requirements

When social login is added:
- use official OmniAuth-compatible patterns carefully
- validate provider identities strictly
- keep email-account linking rules explicit and safe
