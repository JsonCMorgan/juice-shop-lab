# OWASP Juice Shop Lab (Blue Team)

[![Docker](https://img.shields.io/badge/run-docker%20compose-blue)](docker-compose.yml)
![Cost](https://img.shields.io/badge/cost-%240-green)

## For hiring managers (60-second skim)

I run **[OWASP Juice Shop](https://owasp.org/www-project-juice-shop/)** locally, complete representative **OWASP Top 10** challenges, and for each one document:

1. What the attack looks like in **HTTP / application logs**
2. A **detection idea** (Sigma-style condition)
3. The **fix** in plain English

That shows defender thinking, not just CTF badges.

**Related:** [boundry-ai-soc-platform](https://github.com/JsonCMorgan/boundry-ai-soc-platform) SIEM ingest for app events.

---

## Quick start

**Requires:** Docker Desktop (Windows) or Podman.

```bash
git clone https://github.com/JsonCMorgan/juice-shop-lab.git
cd juice-shop-lab
docker compose up -d
# App: http://localhost:3000
```

Stop:

```bash
docker compose down
```

**Safety:** Expose only on `127.0.0.1`. Never put an unpatched Juice Shop on the public internet.

---

## Exercise guide

Work through [docs/challenges-blue-team.md](docs/challenges-blue-team.md) (10 challenges). Log snippets are **representative**; paste your own from container logs when you run locally.

| # | OWASP theme | Detection focus |
|---|-------------|-----------------|
| 1 | Broken Access Control | Forced browsing to `/rest/admin` |
| 2 | Cryptographic Failures | Weak reset tokens in logs |
| 3 | Injection (SQLi) | `OR 1=1` in query params |
| 4 | Insecure Design | Mass assignment / bonus points |
| 5 | Security Misconfiguration | Verbose errors in responses |
| 6 | Vulnerable Components | Outdated dependency banner |
| 7 | Auth failures | High rate of `401` on `/rest/user/login` |
| 8 | Software/data integrity | Unexpected `POST` to API |
| 9 | Logging failures | No audit trail (gap narrative) |
| 10 | SSRF (where applicable) | Internal URL in request params |

Sigma rules for several challenges live in [detections/](detections/).

---

## Repo structure

```
juice-shop-lab/
├── docker-compose.yml
├── docs/challenges-blue-team.md
├── detections/*.yml          # Sigma rules (portable)
└── scripts/tail_juice_logs.ps1
```

---

## Mentor one-liner

"I don't only exploit Juice Shop. For each challenge I wrote what I'd see in logs and how I'd detect it on a SOC shift."