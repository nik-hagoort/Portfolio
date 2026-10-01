# Tooling that drove an App Service → Azure Container Apps migration

**Role:** DevSecOps / SRE · **When:** Mar 2026 – Sep 2026 · **Stack:** Azure Container Apps, App Service, Bicep, Azure DevOps Pipelines, Node.js, PostgreSQL, Entra ID, MCP, Claude Code

## At a glance
| Metric | Value |
|---|---|
| App Service plans tracked | ~110 |
| Migration PRs I merged | 36, across 20 repos |
| PRs to the migration tracker app | 53 |
| Teardown candidates I identified | 57 plans, ~$17k/mo |
| Team teardown that followed | 54 plans + 115 web apps deleted, ~$8.8k/mo confirmed savings |

## The problem
A fleet of ~$410k/yr of App Service hosting needed to move to Container Apps. Each app needed its existing config discovered, new Bicep, a Dockerfile, a pipeline and a safe DNS cutover. Nobody had one view of which apps were done, which old plans could be deleted, or what the migration was actually saving.

## What I did
- Wrote an AI migration skill that clones a repo, reads the live App Service config from Azure, generates Bicep, a Dockerfile and a pipeline to the company's standards, validates them, and opens a draft PR. It updates the tracker automatically at 3 milestones.
- Built the migration tracker: first a static page, then a Container App with PostgreSQL, Entra ID sign-in, full create/read/update/delete (CRUD) and an MCP server, so people and AI agents could both read and update status.
- Added a cost dashboard that splits the fixed workload-profile "rent" from migration-driven spend, and a teardown hit list that cross-checks every old plan's resident apps against the tracker.
- Found that only 1 of 164 old plans had actually been deleted, so almost none of the projected savings had been realized. I turned that into a ranked teardown list of 57 plans worth ~$17k/mo.
- Standardized a "dark launch" pipeline shape (deploy, verify, a disaster-recovery region wake/verify/stop, then manual prod approval) and rolled it across migration pipelines.
- Built a regression detector that diffs Application Insights error signatures across the cutover. On one service it showed 960/960 requests returning 200 in the first hour after cutover.

## Results
- The team deleted 54 plans and 115 web apps in one teardown. Savings of ~$8.8k/mo were confirmed against billing; the team carried out the teardown and I contributed the hit list and tooling.
- The cost dashboard reconstructs per-app Container Apps cost from node billing to within 0.2% of the bill.

## Lessons
- Azure bills App Service per plan, not per app, so savings only land when the whole plan is gone. Track plans, not apps.
- Only report savings once the old resource is actually deleted. Until then the number is projected.
