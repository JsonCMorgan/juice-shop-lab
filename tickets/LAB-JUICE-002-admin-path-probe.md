# LAB-JUICE-002 — Admin path enumeration

| Field | Value |
|-------|-------|
| Severity | Medium |
| OWASP | A01 Broken Access Control |

## Trigger

Repeated `GET /#/administration` and `GET /rest/administration` from single session.

## Evidence

Detection `juice_admin_path.yml` fired 14 times in 3 minutes.

## Decision

Likely **recon** in CTF context; in SOC would verify 404/403 consistency and session auth.

## Actions

- Mapped challenge write-up in `docs/challenges-blue-team.md`.
- Noted fix: enforce RBAC on REST routes, disable debug routes in production builds.