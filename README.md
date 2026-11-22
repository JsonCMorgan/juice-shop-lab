# OWASP Juice Shop Lab (Blue Team)

[![Docker](https://img.shields.io/badge/run-docker%20compose-blue)](docker-compose.yml)
![Cost](https://img.shields.io/badge/cost-%240-green)

## What this repo is

I run **[OWASP Juice Shop](https://owasp.org/www-project-juice-shop/)** locally, work representative **OWASP Top 10** challenges, and for each one I document:

1. What the attack looks like in **HTTP / application logs**
2. A **detection idea** (Sigma-style condition)
3. The **fix** in plain English

I'm not chasing CTF badges for their own sake. I want defender thinking I can explain out loud.

**Related:** [boundry-ai-soc-platform](https://github.com/JsonCMorgan/boundry-ai-soc-platform) SIEM ingest for app events.

Sanitized tickets: [tickets/](tickets/). Detections: [detections/](detections/).

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

**Safety:** Expose only on `127.0.0.1`. I never put an unpatched Juice Shop on the public internet.

---

## Exercise guide

Work through [docs/challenges-blue-team.md](docs/challenges-blue-team.md) (10 challenges). Log snippets in the doc are **representative**; I paste my own from container logs when I run locally.

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

---

## Repo structure

```
juice-shop-lab/
├── docker-compose.yml
├── docs/challenges-blue-team.md
├── detections/*.yml          # Sigma rules (portable)
├── tickets/                  # Sanitized sample tickets
├── screenshots/              # My redacted captures when I add them
└── scripts/tail_juice_logs.ps1
```

---

## One line I use when I explain this lab

"I don't only poke Juice Shop. For each challenge I wrote what I'd see in logs, how I'd detect it, and what I'd tell someone to fix."