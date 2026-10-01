# An unattended overnight AI agent queue

**Role:** Designer and builder · **When:** Sep 2026 · **Stack:** Claude Code (headless), MCP, Bash, tmux, TypeScript

## At a glance
| Metric | Value |
|---|---|
| Cards completed overnight | 41 in its first ~2 weeks |
| Cards blocked for a human | 1 |
| Guardrail constraints per card | up to 7 (read-only, branch-only, no merge, no pipeline run, no cloud writes, no chat posts, no subagents) |
| Max share of the weekly AI quota one night can use | 15% |

## The problem
Much SRE work is long, read-heavy investigation: tracing a deploy path, inventorying a legacy build, or attributing traffic to callers. It doesn't need a human watching, but it was eating daytime hours.

## What I did
- Built a personal task board with a strict card format (brief, done-when checklist, constraints, links, time budget) and an atomic "claim next card" tool, so a headless agent can work one card at a time.
- Wrote the worker skill: one card per run, notes as a heartbeat (a card with no note for 3h is treated as abandoned), a mandatory second-source check on long cards, and a report for the morning.
- Wrote two feeder skills: an end-of-day sweep that proposes up to 5 safe cards, and a mid-task one that carves night-safe work out of the current session. Both propose first and only queue what I pick.
- Built a scheduler driver with quota gating: it reads current usage, keeps a per-day reserve, caps each night at 15 weekly points, and pauses when the 5-hour window passes 80%.
- Added a grading skill that checks each done-when line against the artifacts actually produced, not against the agent's own report.

## Results
- 41 cards done in the first ~2 weeks, including a full discovery for a legacy-monolith migration, a 30-day caller sweep for a WAF change, and several branch-only draft PRs.
- The first night's lesson ("take your time" means nothing to a model) led to checklist-style done-when criteria and a clock check before the agent may finish.

## Lessons
- Unattended agents need hard, machine-checkable stop criteria and constraints. Grade against artifacts, never against the agent's own summary.
