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
| [`2026-09-28-vitrine-11.md`](2026-09-28-vitrine-11.md) | gallery, pass vitrine, request f46f | 4 passed, 0 failed, `passed` — **the vitrine pass is green** | kept: summary, junit, the 9 gallery images (the source of the Workshop gallery) |
| [`2026-09-28-vitrine-10.md`](2026-09-28-vitrine-10.md) | gallery, pass vitrine, request 8bb2, first run on the fixed mod | 2 passed, **2 failed**, both caused by the scenarios' shot marker (the launcher count) now arriving after the light: tests fixed, not rerun | evidence deleted 2026-09-28, superseded by vitrine-11 |
| [`2026-09-27-vitrine-9.md`](2026-09-27-vitrine-9.md) | gallery, pass vitrine, request 2911 | 3 passed, **1 failed** (night light): **root cause found** (CompRefuelable vetoes the light when empty), mod fixed, not yet replayed | evidence deleted 2026-09-28, superseded by vitrine-10 |
| [`2026-09-27-vitrine-8.md`](2026-09-27-vitrine-8.md) | gallery, pass vitrine, request ad7c | 3 passed, **1 failed** (fourth in a row, same step timeout; both timeouts raised, not yet rerun) | evidence deleted 2026-09-27, superseded by vitrine-9 |
| [`2026-09-27-vitrine-7.md`](2026-09-27-vitrine-7.md) | gallery, pass vitrine, request 6702 | 3 passed, **1 failed** (a step timeout, not the application message — machine slowdown suspected), `failed` | evidence deleted 2026-09-27 (there was none: destroyed by this session's own mistake, see the file) |
| [`2026-09-27-vitrine-6.md`](2026-09-27-vitrine-6.md) | gallery, pass vitrine, request e0f0 | 3 passed, **1 failed** (night light: fired, lit=true, glows never followed — game bookkeeping suspect), `failed` | deleted 2026-10-02, superseded by vitrine-11 (and the loose gallery copies with it) |
| [`2026-09-26-vitrine-5.md`](2026-09-26-vitrine-5.md) | gallery, pass vitrine, request f586 | 3 passed, **1 failed** (night light: fired, launch branch ran, light not seen; the trace is at fault-finding stage), `failed` | evidence deleted 2026-09-27, superseded by vitrine-6 |
| [`2026-09-26-vitrine-4.md`](2026-09-26-vitrine-4.md) | gallery, feature 14, pass vitrine, request a79b (98c7 was cut by a shutdown) | 3 passed, **1 failed** (night light: the stand fired, the light not seen), `failed`; the step now traces its state | deleted 2026-09-26, superseded by vitrine-5 |
| [`2026-09-25-vitrine-2.md`](2026-09-25-vitrine-2.md) | gallery, feature 14, pass vitrine, second run | 3 passed, **1 failed** (night light, reproducible), `failed` | deleted 2026-09-26, superseded by vitrine-4 |
| [`2026-09-25-vitrine.md`](2026-09-25-vitrine.md) | gallery, first run | 3 passed, 1 failed, same rouge | deleted 2026-09-25, superseded |
| [`2026-09-25-smoke-4.md`](2026-09-25-smoke-4.md) | smoke stills, smoke rising from the top of the rack | 1 passed, `passed`: the smoke is visible on the stills | kept, summary, junit, 2 stills |
| [`2026-09-25-smoke-3.md`](2026-09-25-smoke-3.md) | smoke stills only, second tuning | 1 passed, `passed`: counted, still barely visible | deleted 2026-09-25, superseded |
| [`2026-09-25-smoke-2.md`](2026-09-25-smoke-2.md) | 2 smoke scenarios, darker smoke | 1 passed, **1 failed**, `failed`: a placement step of the test; dark smoke visible after the launch | deleted 2026-10-02, superseded by smoke-4 |
| [`2026-09-25-smoke.md`](2026-09-25-smoke.md) | 2 smoke scenarios, own fleck, first tuning | 2 passed, `passed`: smoke there, still barely visible | deleted 2026-09-25, superseded |
| [`2026-09-24-smoke.md`](2026-09-24-smoke.md) | 2 smoke scenarios, game's Smoke fleck | 2 passed, `passed`: puffs thrown, not visible on the captures | deleted 2026-09-25, superseded |
| [`2026-09-24-sans-ideology-gizmo.md`](2026-09-24-sans-ideology-gizmo.md) | feature 12 only, without Ideology | 1 passed, `passed` | kept, summary and junit |
| [`2026-09-24-french-0-1-1.md`](2026-09-24-french-0-1-1.md) | 27 scenarios, first 0.1.1 build | 26 passed, **1 failed**, `failed`: the same smoke-step bug | kept, 13 stills, 5 films |
| [`2026-09-24-english-0-1-1.md`](2026-09-24-english-0-1-1.md) | 27 scenarios, 0.1.1 build | 26 passed, **1 failed**, `failed`: the smoke step of the test was wrong, not the mod | kept: summary, junit, 11 stills; the 4 films deleted 2026-10-02 (the junit already says the scenarios ran) |
| [`2026-09-24-english-hang.md`](2026-09-24-english-hang.md) | 27 scenarios, first 0.1.1 attempt | stalled at save/reload, killed by the watchdog; not reproduced | none |
| [`2026-09-24-french.md`](2026-09-24-french.md) | 26 scenarios, reshaped suite (previous build) | 26 passed, `passed` | deleted 2026-09-25, superseded by the 0.1.1 French pass |
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
