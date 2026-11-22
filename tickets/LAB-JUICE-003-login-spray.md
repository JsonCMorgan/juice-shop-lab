# LAB-JUICE-003 — Login spray against authentication

| Field | Value |
|-------|-------|
| Severity | Medium |
| OWASP | A07 Identification and Authentication Failures |

## Trigger

`juice_login_spray.yml`: >15 failed logins for unique usernames in 10 minutes.

## Evidence

Application log pattern: `401` on `/rest/user/login` with rotating `email` field.

## Decision

Brute-force pattern. Lab account lockout disabled (Juice Shop default).

## Actions

- Documented compensating controls: MFA, CAPTCHA after N failures, SIEM correlation with boundry login throttle pattern.