# Led groundwork to containerize a legacy .NET Framework monolith

**Role:** DevSecOps / SRE (co-leading with a teammate) · **When:** Sep 2026 – present · **Stack:** .NET Framework 4.8, IIS, MSBuild, Azure DevOps Release, PowerShell 7, SSH

## At a glance
| Metric | Value |
|---|---|
| Files rewired from bin-drops to real project references | **83** |
| Dead config removed or queued for removal | **~31k lines** across 206 files (in review) |
| Deploy errors root-caused | **16 of 16** in 30 days, one cause |
| New release guards | **5**, with 0 false failures on the first release |
| Unattended research tasks feeding the plan | **~30** |

## The problem
A large IIS-hosted .NET Framework monolith had to start moving toward containers. Its build depended on DLLs copied into bin folders in a fixed order, its deploys silently skipped files, and two competing plans disagreed.

## What I did
- **Wrote one battle plan** across every layer (build, deploy, hosts, edge, state, secrets, DR, observability) in six incremental bites, reconciling the two competing plans into one.
- **Stood up an unattended Windows build host** over SSH so every change is proven by a compiler. Baseline main builds green in ~14s across 4 solutions.
- **Rewired references across 83 files** from bin-drop references to real project references, and added a static validator so they can't regress.
- **Caught a bad release before production** by comparing CI build artifacts: the build was dropping DLLs, which incremental local builds had hidden.
- **Root-caused 16 of 16** web-tier deploy errors from 30 days of history to a single backup step failing on a locked log file.
- **Added 5 release guards** (service stop, lock checks, a services-running check, and post-deploy file verification), shipped report-only first through dry-run-capable scripts.
- **Queued ~31k lines** of dead environment config for removal (206 files, in review).

## Results
- On their first real release, the guards ran with **0 false failures** and caught a component the old process had been silently failing to deploy.
