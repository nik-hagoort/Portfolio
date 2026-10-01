# Plugins for an internal SRE dashboard platform

**Role:** DevSecOps / SRE (plugin author; a teammate owns the platform) · **When:** Aug 2026 – Sep 2026 · **Stack:** TypeScript, Node.js, PostgreSQL, Azure Resource Graph, Azure Cost data, MCP, Azure DevOps

## At a glance
| Metric | Value |
|---|---|
| PRs merged to the dashboard repo | 46 |
| Resources scanned by the idle-spend detector | ~960 |
| Idle spend currently flagged | ~$2.2k/yr with zero traffic, ~$1k/yr near-zero |
| Telemetry refresh | every 2h, automated |

## The problem
The team needed one read-only place to see fleet health, cost and pending decisions, and AI agents needed to use it as well as people.

## What I did
- Wrote the application-telemetry ingest that the platform had left as a stub, so plugins could read request and availability data from a shared warehouse.
- Built a fleet map that shows every service by traffic and availability, grouped by resource group.
- Built an idle-spend detector that flags anything costing money with zero or near-zero traffic, classifies it (dark, dim, standby, too new), tracks how long it has been dark, and links straight into a savings card.
- Ported the container sizing board (see [container-platform-capacity](../container-platform-capacity/)) and fixed 9 defects along the way.
- Exposed each plugin's actions as MCP tools so Claude sessions can read and update the same data people see.
- Built a publishing plugin that hosts the team's weekly newsletters on the dashboard.

## Results
- The idle-spend detector covers ~960 resources and currently flags ~$3.2k/yr of idle or near-idle spend.
- All plugins share one warehouse and never call Azure directly. Access is team-scoped through identity group claims.
