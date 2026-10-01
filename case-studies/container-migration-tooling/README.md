# Built the tooling behind a ~$410k/yr hosting migration and surfaced ~$200k/yr in savings

**Role:** DevSecOps / SRE · **When:** Mar 2026 – Sep 2026 · **Stack:** Azure Container Apps, App Service, Bicep, Azure DevOps Pipelines, Node.js, PostgreSQL, Entra ID, MCP, Claude Code

## At a glance
| Metric | Value |
|---|---|
| Hosting spend in scope | ~$410k/yr across ~110 App Service plans |
| Teardown savings I identified | **~$200k/yr** (57 plans) |
| Savings realized once the team tore them down | **~$140k/yr** measured (54 plans + 115 web apps deleted) |
| Migration PRs I shipped | 36 across 20 repos |
| Migration tracker | built from zero, 53 PRs, live with Entra ID sign-in and an MCP API |
| Accuracy of the per-app cost model | within 0.2% of the actual bill |

## The problem
~$410k/yr of App Service hosting had to move to Azure Container Apps. Every app needed discovery, Bicep, a Dockerfile, a pipeline and a safe cutover. Nobody could see what was done, what could be deleted, or whether any money was being saved.

## What I did
- **Automated the migration itself.** I built an AI skill that reads an app's live Azure config, generates Bicep, a Dockerfile and a pipeline to company standards, validates them and opens the PR. I used it to ship 36 migration PRs across 20 repos.
- **Built the migration tracker** and evolved it from a static page into a production Container App with PostgreSQL, Entra ID sign-in, full create/read/update/delete (CRUD) and an MCP server. Engineers and AI agents update the same source of truth, and the migration skill writes to it automatically at 3 milestones.
- **Found the savings that weren't landing.** A plan-level audit showed only 1 of 164 legacy plans had actually been deleted. I turned that into a ranked teardown list of 57 plans worth **~$200k/yr**.
- **Built the cost dashboard and model** that separates fixed node "rent" from migration-driven spend and reconstructs per-app container cost to **0.2%** of the bill.
- **Standardized safe cutovers.** I designed a dark-launch pipeline (deploy, verify, wake/verify/stop in the DR region, then manual prod approval) and rolled it across the migration pipelines.
- **Proved cutovers clean** with a regression detector that diffs error signatures across the cutover. One example: 960/960 requests returned 200 in the first hour after cutover.

## Results
- **~$140k/yr in measured savings** once the team deleted 54 plans and 115 web apps in one teardown, working from my hit list and tooling.
- A single live view of migration status and savings, used by both engineers and AI agents.

## Lessons
- Azure bills App Service per plan, so savings land only when the whole plan is gone. Track plans, not apps.
