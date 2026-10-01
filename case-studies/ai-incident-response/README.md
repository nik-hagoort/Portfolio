# Multi-agent AI incident investigation

**Role:** DevSecOps / SRE · **When:** Mar 2026 – Jul 2026 · **Stack:** Claude Code, Azure Monitor / Log Analytics, Application Insights, KQL, SQL Server DMVs, Checkly API, Azure DevOps API

## At a glance
| Metric | Value |
|---|---|
| Skill size | ~2,350 lines, 11 files |
| Smoke tests passing at hardening | 14/15 (2 KQL bugs caught and fixed) |
| Formal incident reports produced | 8 |
| Specialists run in parallel per incident | 5 core, plus up to 3 on demand |

## The problem
During a production incident, one engineer has to search logs, app telemetry, SQL blocking, synthetic checks and recent deploys in sequence. That is slow, and it tends to lock onto the first plausible cause.

## What I did
- Built an incident-response skill that launches parallel specialist agents (logs, app telemetry, SQL, synthetic monitoring, CI/CD) and adds metrics, session-replay or source-control agents only when the evidence calls for them.
- Added an adversarial evaluation agent that grades each finding as evidence or inference and downgrades over-confident claims before the report is written.
- Produced a severity-ranked report with a Mermaid timeline for each incident, plus a short summary card.
- Added a pre-flight auth check so 5 agents don't each discover an expired token separately.

## Results
- 8 incident reports between March and July 2026. In one, the evaluation agent and a synthetic-check screenshot overturned a root cause that timing alone suggested.
- In a dev-environment recovery: gateway 504s fell from 324/hr to 9/hr, a 9.7k-message backlog drained, and a 6.8k/hr 401 storm collapsed after the fix.
- For a login outage, I traced front-door stalls to bursts on a 29 MB vendor bundle whose hash changed on every deploy. Proposed fix: pre-compress the bundle (~5x less origin egress, projected).

## Lessons
- A parallel investigation needs an adversarial reviewer. Correlation in time is the most common false root cause.
