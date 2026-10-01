# Built an unattended overnight AI engineer that completed 41 tasks in 2 weeks

**Role:** Designer and builder · **When:** Sep 2026 · **Stack:** Claude Code (headless), MCP, Bash, tmux, TypeScript

## At a glance
| Metric | Value |
|---|---|
| Tasks completed unattended | **41** in its first ~2 weeks |
| Tasks that needed a human | **1** |
| Human hours spent overnight | **0** |
| Safety constraints enforced per task | up to **7** |
| Weekly AI quota allowed per night | **15%** max, gated automatically |

## The problem
Long, read-heavy SRE work (tracing deploy paths, inventorying legacy builds, attributing traffic) was eating daytime hours that didn't need a human watching.

## What I did
- **Designed the task contract:** brief, a done-when checklist, constraints, links and a time budget, plus an atomic "claim next" tool, so a headless agent works exactly one card at a time.
- **Built the worker** with a note on each card as a heartbeat (3 hours of silence means abandoned), a mandatory second-source check on long tasks, and a morning report.
- **Built the intake:** an end-of-day sweep that proposes up to 5 safe tasks, and a mid-session tool that carves night-safe work out of the current job. Both queue only what I approve.
- **Built quota-aware scheduling** that reads live usage, keeps a daily reserve, caps each night at 15% of the weekly quota, and pauses past 80% of the 5-hour window.
- **Built automatic grading** that checks every done-when line against the artifacts actually produced, never against the agent's own summary.

## Results
- **41 tasks done, 1 blocked, 0 human hours.** Output included a full migration discovery for a legacy monolith, a 30-day caller sweep for a WAF change, and branch-only draft PRs.
- The approach became the research engine behind a monolith modernization program (~30 tasks).
