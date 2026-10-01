# Identified ~$36k/yr in SQL Server storage savings and stopped a cut that would have hurt production

**Role:** DevSecOps / SRE · **When:** Aug 2026 – Sep 2026 · **Stack:** Azure Ultra Disk, Premium SSD v2, Azure Monitor per-LUN metrics, Python, FinOps Hub (Kusto)

## At a glance
| Metric | Value |
|---|---|
| Savings identified, tiers 1–2 | **~$36k/yr** *(projected)* |
| Tier 1 (zero performance impact) | **~$13k/yr** *(projected, awaiting approval)* |
| Harmful cuts caught and pulled before shipping | **~$29k/yr** |
| Evidence base | **92 days** at 1-minute grain, per drive, primary + HA |
| Billing error caught | a disk mislabeled at **2x** its real price tier |

## The problem
Production SQL Server ran on premium Ultra disks provisioned years earlier. Leadership wanted to know how much could be cut without degrading the database.

## What I did
- **Caught my own bad plan before it shipped.** An average-based plan proposed ~$29k/yr of cuts. Re-checked at 1-minute, cache-excluded grain, every prod cut would have saturated during weekly maintenance, so I pulled it.
- **Rebuilt it in tiers:** Tier 1 is risk-free (archive-tier disk for DR, delete an unused disk, move dev to Premium v2). Tier 2 needs the data team to accept slower maintenance. A later tier replatforms.
- **Reconciled list prices against actual billing,** which caught a disk mislabeled at twice its real tier and confirmed there is no contract discount on disk meters.
- **Built a 92-day evidence pack** for both replicas and matched every saturation window to a scheduled SQL Agent job: 93–100% peaks happen only inside index maintenance and integrity checks.
- **Presented to an external DBA partner and the in-house DBAs,** and wrote their rule into the plan: cut only where 1-minute IO stays well under 70–80% on both replicas.

## Results
- **~$36k/yr** of savings identified (projected), with **~$13k/yr** ready to execute at zero risk.
- I documented two reusable measurement traps: Azure's disk-level "maximum" metric silently equals the average, and composite disk metrics include host-cache hits.
