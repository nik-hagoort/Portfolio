# Built a multi-agent AI incident-response system

**Role:** DevSecOps / SRE · **When:** Mar 2026 – Jul 2026 · **Stack:** Claude Code, Azure Monitor / Log Analytics, Application Insights, KQL, SQL Server DMVs, Checkly API, Azure DevOps API

## At a glance
| Metric | Value |
|---|---|
| Specialist agents investigating in parallel | **5 core + 3 on-demand** |
| System size | ~2,350 lines, 11 files, 14/15 smoke tests passing |
| Production incident reports delivered | **8** |
| Gateway 504s in one recovery | **324/hr → 9/hr (−97%)** |
| 401 storm in the same recovery | **~6.8k/hr → resolved** |

## The problem
Incident triage meant one engineer working through logs, app telemetry, SQL blocking, synthetic checks and recent deploys one at a time. It was slow, and the first plausible cause usually won.

## What I did
- **Designed a parallel investigation team.** Logs, app telemetry, SQL, synthetic-monitoring and CI/CD agents run at once, and metrics, session-replay and source-control specialists join only when the evidence calls for them.
- **Added an adversarial evaluator** that grades every finding as evidence or inference and downgrades over-confident root causes before they reach the report.
- **Automated the output:** a severity-ranked report with a Mermaid timeline, plus a summary card for chat.
- **Hardened it for real use** with pre-flight auth checks, a VPN gate for production SQL access, and a smoke-test suite that caught 2 KQL bugs before they reached an incident.

## Results
- **8 formal incident reports** delivered. In one, the evaluator and a synthetic-check screenshot overturned a root cause that timing alone suggested.
- During a dev-environment recovery, gateway 504s fell **97%**, a **9.7k-message** backlog drained, and a **6.8k/hr** authentication-error storm was eliminated.
- For a login outage, I traced front-door stalls to a 29 MB vendor bundle whose hash changed on every deploy, and specified a fix projected to cut origin egress ~5x.
