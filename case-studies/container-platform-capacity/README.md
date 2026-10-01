# Fixed capacity deadlocks and right-sized a Container Apps fleet with data

**Role:** DevSecOps / SRE · **When:** May 2026 – Sep 2026 · **Stack:** Azure Container Apps (dedicated workload profiles), KEDA, Azure Monitor, KQL, Node.js, Python

## At a glance
| Metric | Value |
|---|---|
| Prod Container Apps graded per run | ~100 in 154s |
| Average CPU use vs CPU allocated across the fleet | ~2% |
| Cores wasted by a rollout deadlock | ~38 |
| Nodes freed by moving one workload to a bigger profile | ~16 (headroom held through peak) |
| Dev apps switched to scale-to-zero | 22 now, plus 44 open migration PRs |
| Apps reviewed per AI pass on the sizing board | ~90 |

## The problem
New deployments were failing because the shared dedicated node pool was full. Every app was sized by guesswork, and the fleet was paying for nodes it barely used.

## What I did
- Traced the node-cap crunch to two stuck rollouts that double-ran their replicas (~38 cores), not to ghost replicas. I moved the largest workload to a bigger profile, which freed ~16 nodes, and confirmed the headroom held through the afternoon peak.
- Set 22 dev apps to scale to zero and changed the migration template so every new dev app defaults to it.
- Built a sizing analyzer: it collects 7 days of hottest-window load plus 30 days of sustained peaks per app and recommends CPU, memory, min/max replicas and the scaling rule. Grades in one run: A 9 / B 32 / C 31 / D 17 / F 12.
- Switched from raw 1-minute peaks to sustained peaks. That cut the "needs more CPU" list from 52 apps to 37 and stopped single spikes from driving upsizes.
- Shipped a decision board where each recommendation gets an in-session AI review (endorse, flag or reject) before a human decides.

## Results
- After the profile move, the afternoon peak was a non-event, with 16+ nodes of headroom.
- The first three production trims went out with zero rollbacks. Memory headroom stayed at 15–35% of the new limits and latency didn't change.
- Billing showed that per-app savings on shared nodes mostly can't be measured: only node count moves the bill. I now report fleet-level node savings instead of per-app dollars.

## Lessons
- On shared node billing, right-sizing pays only when it frees a whole node. Plan trims in node-sized batches.
- Measure a sustained load, never a single maximum.
