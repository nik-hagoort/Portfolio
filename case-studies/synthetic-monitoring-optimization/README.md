# Cut synthetic-monitoring cost ~$11k/yr while driving test failures to 0%

**Role:** DevSecOps / SRE · **When:** Mar 2026 – May 2026 · **Stack:** Checkly, Playwright, TypeScript, Checkly CLI, Python

## At a glance
| Metric | Before | After |
|---|---|---|
| Tests optimized | 0 | 13 (8 converted to flat-rate browser checks) |
| Failure rate on the worst check | 10% | 0% |
| Runtime of the slowest optimized check | 532s | 349s (34% faster) |
| Fastest single win | 93s | 24s (74% faster) |
| Estimated monitoring spend cut | — | ~$940/mo (~$11k/yr) across 12 PRs |
| Savings ceiling identified | — | ~$3.7k/mo (68% of spend) if the full suite is converted |

## The problem
The company runs ~90 synthetic end-to-end checks against production every 30–60 minutes. Playwright checks are billed by runtime (one extra run per 30 seconds), so slow, flaky tests were both the biggest line item and the noisiest source of false alerts. The plan was trending toward an overage.

## What I did
- Wrote a ranking script against the Checkly API that scores every check by cost (runs per execution × frequency) and failure rate, so work went to the most expensive checks first.
- Replaced blind `waitForTimeout` sleeps (up to 60s each) with condition-based waits and API polling, fixed non-retrying visibility checks, and swapped brittle XPath selectors for CSS.
- Converted 8 short checks to browser checks, which bill a flat single run.
- Validated every change locally with Playwright and then in the Checkly cloud (5/5 passes on the worst offender) before opening 12 PRs.
- Packaged the method as a reusable AI skill with a ledger and management report. In an A/B eval it scored 90% with the skill vs 81% without.
- Built a usage dashboard that tracks the daily run rate before and after changes, with an executive summary for leadership.
- Later added production paging: Zoom and SMS alert channels attached to the critical production checks.

## Results
- Failure rate on all 13 optimized checks went to 0%. Average runtime fell 20%.
- Shipped 12 PRs with ~$940/mo (~$11k/yr) of estimated monitoring savings, and mapped a ~$3.7k/mo (68%) ceiling for the rest of the suite.
- 10 of the 12 PRs verified passing in the Checkly cloud before review.
- Some checks had no safe optimization, for example a 65s wait that tests a real lunch-break rule, and I left them alone rather than weaken coverage.

## Lessons
- Re-measure claims against the live 7-day window before reporting. Two PRs' "before" numbers had drifted by ~15% from the sliding window.
- Never open a PR with untested changes: validate locally first and use the cloud run as the final sanity check.
