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

**Keep only what matters.** After a run has been read, the evidence on disk is trimmed to the most relevant: the raw
`summary.json` and `junit.xml`, the images (minified to jpeg by `Run-Passes.ps1`) and films that show something, and nothing derived (contact sheets,
half-size copies), no log or messages file, no image that a later change of the suite makes obsolete or that carries
the film's corner frame. The trim is written in the run's summary, with what was deleted.

**Superseded evidence goes as soon as a newer report replaces it** (root `AGENTS.md`, "Test evidence"). The evidence of
`2026-09-21-french-full` is the only proof of its scenarios until a pass of the reshaped suite has been read; then it is
deleted and its summary stays as one line above.
