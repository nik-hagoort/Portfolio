# Unblocked a production WAF lockdown by attributing ~3.2M requests/yr of unexplained traffic

**Role:** DevSecOps / SRE · **When:** Jun 2026 – Sep 2026 · **Stack:** Cloudflare WAF, Azure DNS, Azure Application Gateway, Azure AD B2C, KQL, GitHub Actions/App tokens

## At a glance
| Metric | Value |
|---|---|
| Unexplained WAF matches attributed | **~62k/week (~3.2M/yr)**, all traced to 5 sources |
| Residual after attribution | ~200/week, all internet scanners |
| Production MFA outage avoided | sign-up flow found and excluded before the block |
| Stale public DNS records removed | **83** (60 prod, 23 dev) |
| Vulnerabilities remediated ahead of deadline | **1 critical + 36 high** |
| CI pipelines moved off a personal token | **7** templates drafted to GitHub App tokens |

## The problem
A WAF rule meant to lock internal services away from the internet had sat in log-only mode for months. ~62k weekly matches came from callers nobody could identify, so blocking risked a production outage.

## What I did
- **Attributed every request** by joining WAF logs with gateway and application telemetry. The "unknown integrator" was the identity provider's own MFA enrollment flow, and blocking it would have broken MFA sign-up. I specified precise path exclusions.
- **Traced the other 4 sources** to stale public URLs in a release variable, a key-vault override that loaded after environment variables, and a worker config file. For each I wrote the exact fix to move it to private endpoints.
- **Wrote a standalone flip-day runbook** so the security owner can execute the block and roll it back.
- **Cleaned up DNS:** deleted 83 stale public records, kept restore files, watched traffic, and then added a code-search and liveness gate to every future deletion.
- **Remediated 1 critical and 36 high vulnerabilities** on a build host ahead of the security team's deadline.
- **Removed a single-person dependency** by mapping every CI use of one engineer's expiring personal token and drafting the move of all 7 templates to short-lived GitHub App tokens.

## Results
- **~3.2M requests/yr** of unexplained traffic fully accounted for, which turned a risky block into a data-backed decision.
- **83 stale records** removed from the public attack surface.
