# Juice Shop: Blue team write-ups (10 challenges)

**How to read this:** each section is *exploit for learning* → *what logs show* → *detection* → *fix*. IPs are fictional.

---

## 1. Broken Access Control (admin section)

**Attack (lab):** Browse to `/rest/admin/application-configuration` without proper authorization.

**Log clue:** `GET /rest/admin/...` returns `200` for a session that never completed admin login.

**Detection:** Unauthenticated or low-privilege user hits admin API paths. See [detections/juice_admin_path.yml](../detections/juice_admin_path.yml).

**Fix:** Enforce server-side authorization on every sensitive route; do not hide URLs as security.

---

## 2. Cryptographic Failures (password reset)

**Attack:** Predictable or leaked reset tokens in responses.

**Log clue:** `POST /rest/user/reset-password` with repeated tokens; emails or tokens in response body in dev mode.

**Detection:** Spike in reset requests from one `src_ip`; same `User-Agent` brute-forcing tokens.

**Fix:** Cryptographically random tokens, short TTL, rate limit, no token echo in API body.

---

## 3. SQL Injection (login/search)

**Attack:** `' OR 1=1--` style payloads in login or product search.

**Log clue:** Query string contains `OR`, `--`, `UNION`, or encoded variants (`%27`, `%20OR%20`).

**Detection:** See [detections/juice_sqli_params.yml](../detections/juice_sqli_params.yml).

**Fix:** Parameterized queries only; WAF is compensating, not primary.

---

## 4. Insecure Design (bonus / loyalty manipulation)

**Attack:** Tamper with JSON fields (e.g., negative quantities, bonus points).

**Log clue:** `PUT` or `POST` with unexpected JSON keys; `200` after business-logic should reject.

**Detection:** API schema validation failures (422) sudden drop + prior 200 tamper pattern.

**Fix:** Server-side validation of all fields; signed cart state.

---

## 5. Security Misconfiguration (verbose errors)

**Attack:** Trigger stack traces via malformed input.

**Log clue:** Response length spike; body contains `Error`, stack file paths, `at Object.`.

**Detection:** HTTP 500 rate + error keyword in body (app log field).

**Fix:** Generic error to client; log details server-side only.

---

## 6. Vulnerable and Outdated Components

**Attack:** Fingerprint `/version` or dependency banners.

**Log clue:** Scanner `User-Agent` (`nikto`, `zap`) hitting `/ftp`, `/api/Challenges`.

**Detection:** Many `404` or `200` on version endpoints from one IP in 60s.

**Fix:** Patch, remove banners, dependency scanning in CI.

---

## 7. Identification and Authentication Failures

**Attack:** Password spray on `/rest/user/login`.

**Log clue:** Many `401` responses, same username or same password across users.

**Detection:** See [detections/juice_login_spray.yml](../detections/juice_login_spray.yml).

**Fix:** MFA, lockout, CAPTCHA after N fails, SIEM alert on spray pattern.

---

## 8. Software and Data Integrity Failures

**Attack:** Unexpected file or package upload if enabled in a given Juice Shop version.

**Log clue:** `POST` multipart with executable extensions.

**Detection:** Upload MIME/extension mismatch; ClamAV or EDR hook (narrative for interview).

**Fix:** Code signing, integrity checks, no unsigned plugins in prod.

---

## 9. Security Logging and Monitoring Failures

**Attack (meta):** Complete a challenge and verify **no** central audit trail.

**Log clue:** Only container stdout; no `who did what` for fraud actions.

**Detection:** Gap analysis: critical mutations without `audit_log` row.

**Fix:** Structured app audit log → SIEM (same pattern as Boundry `/api/ingest`).

**Boundry tie-in:** Your platform ingests Flask auth and attack-sim events to `siem_events` — that closes this gap in your own design.

---

## 10. SSRF / outbound abuse (if challenge available)

**Attack:** Server fetches internal URL supplied in parameter.

**Log clue:** Backend HTTP client errors to `169.254.169.254` or `127.0.0.1` in param.

**Detection:** Outbound from app server to RFC1918 after user-controlled URL param.

**Fix:** Blocklist URLs, no raw socket from user input, metadata service protection.

---

## Interview close

"I used Juice Shop to practice OWASP categories, but I graded myself on detections: every exploit became a log pattern and a Sigma-style rule I'd feed a SIEM."