# LAB-JUICE-001 — SQL injection attempts in HTTP logs

| Field | Value |
|-------|-------|
| Severity | High |
| App | OWASP Juice Shop (local docker) |
| OWASP | A03 Injection |

## Trigger

Detection `juice_sqli_params.yml`: URI contained `'` or `UNION SELECT` patterns.

## Evidence

```
GET /rest/products/search?q=' OR 1=1--
200 OK (vulnerable app response)
```

## Decision

True positive for **lab vulnerability** (expected). In production this would be blocked by WAF + param binding.

## Remediation (documented)

- Parameterized queries at application layer.
- WAF rule for SQLi signatures on public endpoints.
- Rate limit search API.