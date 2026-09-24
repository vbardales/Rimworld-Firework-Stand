# Pickle runs: text summaries

Evidence of a Pickle run (the report, the captures and the films) **stays on disk and out of git**, under
`Tests/Pickle/runs/<date>-<pass>/`, which `.gitignore` ignores. What is committed is a **text summary** of each run,
here: the counts, `exitReason`, every scenario's outcome, the failure messages and the list of evidence kept.
`Tests/Pickle/Run-Passes.ps1` writes both as soon as a pass returns. Which evidence to keep, and when to delete it, is in
`TESTING.md`, "Evidence to keep".

Read `exitReason` before the counts. A summary says a run went to its end, not that an image shows anything: whether a
capture or a film is right is a person's judgement, recorded in the summary's validation line once made.

One line per run, newest first. A run whose evidence was superseded keeps its line and its summary; its folder is gone.

| Run | Suite | Result | Evidence |
| --- | --- | --- | --- |
| [`2026-09-24-english-0-1-1.md`](2026-09-24-english-0-1-1.md) | 27 scenarios, 0.1.1 build | 26 passed, **1 failed**, `failed`: the smoke step of the test was wrong, not the mod | kept, 11 stills, 4 films |
| [`2026-09-24-english-hang.md`](2026-09-24-english-hang.md) | 27 scenarios, first 0.1.1 attempt | stalled at save/reload, killed by the watchdog; not reproduced | none |
| [`2026-09-24-french.md`](2026-09-24-french.md) | 26 scenarios, reshaped suite (previous build) | 26 passed, `passed` | kept, 7 stills; superseded by the 0.1.1 French pass |
| [`2026-09-23-english.md`](2026-09-23-english.md) | 26 scenarios, reshaped suite (previous build) | 26 passed, `passed` | deleted 2026-09-24, superseded by the 0.1.1 English pass |
| [`2026-09-24-sans-ideology.md`](2026-09-24-sans-ideology.md) | first attempt, whole suite | killed as stalled: the fixture throws every tick without Ideology; not a result about the mod | deleted |
| 2026-09-21 20:28, English, **report lost** | 21 scenarios, earlier shape | 18 passed, **1 failed**, 2 skipped, `failed`; which scenario failed is unknown | none |
| [`2026-09-21-french-full.md`](2026-09-21-french-full.md) | 21 scenarios, earlier shape | 21 passed, `passed` | deleted 2026-09-24, superseded |
| [`2026-09-21-english-first-four.md`](2026-09-21-english-first-four.md) | first four features, 11 scenarios | 8 passed, 3 skipped, `passed` | deleted 2026-09-23, superseded |

The 20:28 English run has no summary: its report was archived, then pruned by later runs before anyone read it, and only
the totals survive from the launcher's output. That loss is why `Run-Passes.ps1` exists.

**Keep only what matters.** After a run has been read, the evidence on disk is trimmed to the most relevant: the raw
`summary.json` and `junit.xml`, the images (minified to jpeg by `Run-Passes.ps1`) and films that show something, and
nothing derived (contact sheets, half-size copies), no log or messages file, no image that a later change of the suite
makes obsolete or that carries the film's corner frame. The trim is written in the run's summary, with what was deleted.

**Superseded evidence goes as soon as a newer report replaces it** (root `AGENTS.md`, "Test evidence"), and its summary
stays as one line above.
