# Freed ~16 nodes of Container Apps capacity and built data-driven right-sizing

**Role:** DevSecOps / SRE · **When:** May 2026 – Sep 2026 · **Stack:** Azure Container Apps (dedicated workload profiles), KEDA, Azure Monitor, KQL, Node.js, Python

## At a glance
| Metric | Value |
|---|---|
| Nodes freed by one profile move | **~16** (~$3.6k/mo of capacity at retail, est.) |
| Cores reclaimed from a rollout deadlock | **~38** |
| Production apps graded for sizing | **~100 in 154 seconds** |
| False "needs more CPU" calls removed | 52 → 37 (**−29%**) |
| Dev apps moved to scale-to-zero | **22** live, plus the default for **44** in-flight migrations |
| Production trims rolled back | **0** |

## The problem
Deployments were failing because the shared node pool was full, yet the fleet was using only ~2% of the CPU it had allocated. Apps were sized by guesswork.

## What I did
- **Diagnosed the capacity outage.** It wasn't ghost replicas: two stuck rollouts were double-running (~38 cores). I moved the heaviest workload to a larger profile, which freed **~16 nodes**, and confirmed the afternoon peak was a non-event.
- **Made dev scale to zero.** I switched 22 apps over and changed the migration template so all 44 in-flight migrations default to it.
- **Built a sizing analyzer** that grades ~100 production apps in 154s. It sizes from the hottest 2h of 7 days and 30 days of sustained peaks, and recommends CPU, memory, replica bounds and the scaling rule.
- **Raised recommendation quality.** Sizing from sustained load instead of 1-minute spikes cut false upsize calls by 29%.
- **Shipped a decision board** where an AI review (endorse, flag or reject) runs on every recommendation before a human applies it.

## Results
- The capacity crunch was cleared, with 16+ nodes of headroom through peak.
- The first production trims shipped with **zero rollbacks**. Memory headroom stayed at 15–35% and latency didn't change.
- I established that shared-node billing only drops when a whole node frees, and switched the team's savings reporting to node level.
