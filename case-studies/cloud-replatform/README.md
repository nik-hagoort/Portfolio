# Re-platformed an entire Azure App Service estate onto Container Apps in under 4 months

**Role:** DevSecOps / SRE, migration automation lead on the SRE team · **When:** Apr 2026 – Jul 2026 (savings tracked through Sep) · **Stack:** Azure Container Apps, App Service, Bicep, Azure DevOps Pipelines, KEDA, Node.js, PostgreSQL, Entra ID, MCP, Claude Code

## At a glance
| Metric | Before (Apr 2) | After |
|---|---|---|
| Hosting platform | ~110 App Service plans, **~$412k/yr** | **~280 Container Apps** (~100 prod, ~75 warm DR, ~100 dev) |
| Apps migrated | 0 | entire in-scope estate in **under 4 months** |
| Legacy teardown | — | **54 plans + 115 web apps deleted in one day** |
| Confirmed cloud savings (team) | — | **~$590k/yr** across 33 billing-verified actions |
| Teardown savings alone | — | **~$140k/yr** measured |

## The problem
The company's product ran on ~110 Azure App Service plans costing ~$412k/yr: one plan per app, sized by guesswork, with no shared scaling and a disaster-recovery story that depended on standing duplicates. The goal was to move everything onto Azure Container Apps without breaking a payroll platform that can't go down on pay day.

## What I did
- **Built the migration machine.** I wrote an AI skill that reads an app's live Azure config and generates Bicep, a Dockerfile and a CI/CD pipeline to company standards, validates them and opens the PR. I shipped 36 migration PRs across 20 repos with it myself, and the team used the same pattern across the fleet.
- **Built the command center.** The migration tracker went from a static page on day one to a production app with PostgreSQL, Entra ID sign-in and an MCP API that engineers and AI agents both update. It tracked every app from not-started to torn-down.
- **Made cutovers boring.** I designed the dark-launch pipeline (deploy, verify, wake/verify/stop in the DR region, then manual prod approval) and rolled it across ~50 migration pipelines, so every app proved itself in dev and DR before production saw it.
- **Audited at fleet scale.** One tool checks ~290 apps against live Azure, gateway routing and pipeline history in ~50 seconds, and another scanned all 230 company repos for hard-coded legacy hostnames before cutover.
- **Proved each cutover clean** with a regression detector that diffs error signatures before and after. One example: 960/960 requests returned 200 in the first hour.
- **Found the money that wasn't landing.** A plan-level audit showed 1 of 164 legacy plans actually deleted, because Azure bills per plan rather than per app. I turned it into a ranked teardown list worth ~$200k/yr, which drove the single-day teardown.
- **Kept the new platform healthy.** I diagnosed a capacity deadlock during the rollout, moved dev to scale-to-zero, and built a sizing analyzer that grades ~100 production apps in 154 seconds.

## Results
- **Entire App Service estate re-platformed in under 4 months**: ~110 plans became ~280 Container Apps across production, a warm DR region and dev.
- **54 legacy plans and 115 web apps retired in a single day.**
- **~$590k/yr in confirmed cloud savings** for the team's cost program, with ~$140k/yr from the teardown alone.
- A per-app cost model that reconstructs the shared-node bill to within **0.2%**.

## Lessons
- Track the unit Azure bills: plans, not apps. Savings only land when the whole plan is gone.
- Automate the boring 80% (scaffolding, pipelines, audits) so people can spend their time on the risky 20% (cutovers).
