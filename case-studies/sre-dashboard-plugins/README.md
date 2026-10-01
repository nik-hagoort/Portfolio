# Built the cost, capacity and fleet plugins for an internal SRE platform

**Role:** DevSecOps / SRE (plugin author; a teammate owns the platform) · **When:** Aug 2026 – Sep 2026 · **Stack:** TypeScript, Node.js, PostgreSQL, Azure Resource Graph, Azure Cost data, MCP, Azure DevOps

## At a glance
| Metric | Value |
|---|---|
| PRs merged to the platform | **46** in ~6 weeks |
| Resources under continuous idle-spend watch | **~960** |
| Idle or near-idle spend flagged right now | ~$3.2k/yr |
| Defects fixed while porting the sizing board | 9 |
| Telemetry refresh | automated, every 2 hours |

## The problem
The team had no single read-only view of fleet health, cost and pending decisions, and AI agents had no way to use one.

## What I did
- **Wrote the application-telemetry ingest** the platform had left as a stub, so every plugin reads request and availability data from a shared warehouse.
- **Built an idle-spend detector** that watches ~960 resources for cost with zero or near-zero traffic. It classifies each one (dark, dim, standby, too new), tracks how long it has been dark, and turns a finding into a savings card in one click.
- **Built a fleet map** showing every service by traffic and availability, grouped by resource group.
- **Ported and hardened the container sizing board**, fixing 9 defects on the way (see [cloud-replatform](../cloud-replatform/)).
- **Made it AI-native:** every plugin action is also an MCP tool, so Claude sessions work from the same data people see.
- **Built a publishing plugin** that hosts the team's weekly newsletters.

## Results
- **46 PRs** merged in about 6 weeks, live for the whole team.
- Idle spend now gets flagged automatically instead of being found by hand.
