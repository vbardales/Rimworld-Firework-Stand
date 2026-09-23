# Pickle runs: text summaries

Evidence of a Pickle run (the report, the log, the captures and the films) **stays on disk and out of git**, under
`Tests/Pickle/runs/<date>-<pass>/`, which `.gitignore` ignores. What is committed is a **text summary** of each run,
here: the counts, `exitReason`, every scenario's outcome, the failure messages and the list of evidence files.
`Tests/Pickle/Run-Passes.ps1` writes both as soon as a pass returns.

Read `exitReason` before the counts. A summary says a run went to its end, not that an image shows anything: whether a
capture or a film is right is a person's judgement, recorded in the summary's "Validated by a person" line once made.

| Run | Suite | Result |
| --- | --- | --- |
| [`2026-09-21-english-first-four.md`](2026-09-21-english-first-four.md) | first four features, 11 scenarios | 8 passed, 3 skipped, `passed` |
| 2026-09-21 20:28, English, **report lost** | 21 scenarios | 18 passed, **1 failed**, 2 skipped, `failed`; which scenario failed is unknown |
| [`2026-09-21-french-full.md`](2026-09-21-french-full.md) | 21 scenarios (before the suite was reshaped) | 21 passed, `passed` |

The 20:28 English run is listed for the record and has no summary: its report was archived, then pruned by later runs
before anyone read it, and only the totals survive from the launcher's output. That loss is why `Run-Passes.ps1`
exists.
