# Groundwork for modernizing a legacy .NET Framework monolith

**Role:** DevSecOps / SRE (co-leading with a teammate) · **When:** Sep 2026 – present · **Stack:** .NET Framework 4.8, IIS, MSBuild, Azure DevOps Release, PowerShell 7, SSH

## At a glance
| Metric | Value |
|---|---|
| PRs merged to the monolith | 9 |
| Deploy errors root-caused (30-day history) | 16 of 16, one cause |
| New deploy guards on first real release | 5 of 5 passed, 0 false failures |
| Unattended investigation cards behind the plan | ~30 |

## The problem
A large IIS-hosted .NET Framework monolith had to start moving toward containers. Its build depended on DLLs dropped into bin folders in a specific order, its deploys sometimes skipped files silently, and two existing plans for the work didn't agree.

## What I did
- Wrote one battle plan across every layer (build, deploy, hosts, edge, state, secrets, DR, observability), split into six incremental bites.
- Set up an unattended Windows build host over SSH so changes are proven by a compiler. Baseline main builds green in ~14s across 4 solutions.
- Converted bin-drop references to real project references, with a static validator. Comparing build artifacts caught a release that dropped DLLs, which incremental local builds had hidden.
- Traced a 30-day history of deploy errors on the web tier: 16 of 16 were one backup step failing on a locked log file.
- Added 5 deploy guards to the release pipeline: stop services, lock checks, a services-running check, and a post-deploy file verification. They run in report-only mode first and are applied by a dry-run-capable script.

## Results
- On the first real release, all 5 guards ran with no false failures and caught a component the old process silently failed to deploy.

## Lessons
- In a legacy build, compare the artifacts the CI pipeline actually produces before releasing. A green local build proves very little.
