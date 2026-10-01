# Made production E2E monitoring faster, cheaper and more reliable

**Role:** DevSecOps / SRE · **When:** Mar 2026 – May 2026 · **Stack:** Checkly, Playwright, TypeScript, Checkly CLI, Python

## At a glance
| Metric | Before | After |
|---|---|---|
| Tests optimized | 0 | 13 (8 converted to flat-rate browser checks) |
| Failure rate on the worst check | 10% | 0% |
| Runtime of the slowest optimized check | 532s | 349s (34% faster) |
| Fastest single win | 93s | 24s (74% faster) |
| Monthly check runs | baseline | ~30k fewer per month |

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
- ~30k fewer check runs per month (measured from the run-rate model, ~$120/mo). An earlier ~$940/mo figure was a projection across the whole suite and is not claimed here.
- Some checks had no safe optimization, for example a 65s wait that tests a real lunch-break rule, and I left them alone rather than weaken coverage.

## Lessons
- Re-measure claims against the live 7-day window before reporting. Two PRs' "before" numbers had drifted by ~15% from the sliding window.
- Never open a PR with untested changes: validate locally first and use the cloud run as the final sanity check.
