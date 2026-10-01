# Edge security and DNS hygiene

**Role:** DevSecOps / SRE · **When:** Jun 2026 – Sep 2026 · **Stack:** Cloudflare WAF, Azure DNS, Azure Application Gateway, Azure AD B2C, KQL, GitHub code search

## At a glance
| Metric | Value |
|---|---|
| WAF rule matches attributed | ~62k/week, to 5 sources |
| Residual after attribution | ~200/week (internet scanners, safe to block) |
| Stale public DNS records removed | 83 (60 prod, 23 dev) |
| Vulnerabilities cleared ahead of a security deadline | 1 critical + 36 high |

## The problem
A WAF rule meant to block public access to internal-only services had sat in log-only mode for months. ~62k weekly matches came from callers nobody could name, so flipping it to block risked breaking production. Separately, years of DNS records pointed at retired hosts.

## What I did
- Attributed every weekly match by joining WAF logs with gateway and app telemetry. The "unknown third-party integrator" turned out to be the identity provider's own MFA phone-enrollment flow; blocking it would have broken MFA sign-up. I specified path exclusions for it.
- Traced the other 4 sources to stale public URLs in a release variable, a key vault override that loaded after environment variables, and a worker's config file. For each I wrote the exact fix to point it at the private host.
- Wrote a standalone flip-day runbook so the security owner can execute and roll back without me.
- Deleted 83 stale DNS records, kept restore files, and watched traffic for 2.5h.
- Cleared 1 critical and 36 high vulnerabilities on a build host before the security team's deadline.
- Mapped every use of a single engineer's expiring personal GitHub token in CI and drafted the switch of all 7 consuming templates to short-lived GitHub App tokens (waiting on an org admin to create the App).

## Results
- The block decision now rests on an accounted-for traffic table instead of a guess.
- One dev alias that looked stale was still live; it was restored the same day. Since then every DNS deletion is gated on an org-wide code search plus a liveness check on the target.
