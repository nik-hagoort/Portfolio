# An evidence-first plan to cut SQL Server storage cost

**Role:** DevSecOps / SRE · **When:** Aug 2026 – Sep 2026 · **Stack:** Azure Ultra Disk, Premium SSD v2, Azure Monitor per-LUN metrics, Python, FinOps Hub (Kusto)

## At a glance
| Metric | Value |
|---|---|
| Tier-1 savings (no performance impact) | ~$1.1k/mo, ~$13k/yr *(projected, awaiting approval)* |
| First plan I retracted | ~$2.4k/mo of cuts that would have hurt performance |
| History analyzed | 92 days at 1-minute grain, per drive, primary and HA replicas |

## The problem
Production SQL Server ran on expensive Ultra disks provisioned years earlier. Leadership wanted to know how much could be cut without hurting performance.

## What I did
- Built a first plan from averages ($2.4k/mo), then re-checked it at 1-minute, cache-excluded grain. Every proposed prod cut would have saturated during weekly in-guest maintenance windows, so I retracted it before it shipped.
- Rebuilt the plan in tiers. Tier 1 is performance-neutral: archive-tier disk for a DR drive, delete an unused disk, and swap a dev disk to Premium v2. Later tiers need the data team to accept slower maintenance.
- Reconciled the retail price API against actual billed cost. That caught an inventory mislabel (a disk billed at half the assumed size tier) and confirmed there's no contract discount on disk meters.
- Pulled 92 days of per-drive load for both replicas and matched every saturation window to scheduled SQL Agent jobs. 93–100% peaks happen only inside index maintenance and integrity checks; only the data disk is busy during business hours.
- Presented the plan to an external DBA partner and the in-house DBAs, and adopted their rule: cut only where 1-minute IO stays well under 70–80% on both replicas.

## Results
- Tier 1 (~$13k/yr, projected) has no performance impact and is awaiting approval.
- Documented reusable measurement traps: Azure's disk-level "maximum" metric silently equals the average, and composite metrics include host-cache hits.

## Lessons
- Average utilization hides saturation. Size storage from per-drive 1-minute peaks and know what runs in each window.
