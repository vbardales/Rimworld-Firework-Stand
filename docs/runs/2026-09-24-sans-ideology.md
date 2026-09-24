# Pickle run: without Ideology, 2026-09-24, first attempt (not a result about the mod)

- **exitReason:** `in-progress`. Launcher exit code: 3 (the run was killed as stalled).
- **Scenarios:** 15 discovered, 5 passed, 10 failed, 0 skipped. Played with `-DepMap wsl-deps.sans-ideology.map`.
- **Evidence:** deleted on 2026-09-24, it proves nothing about the mod (see below).

**Why it failed: the fixture, not the stand.** Every scenario that ran the game clock failed on the same line,
`Exception ticking Larson ... System.NullReferenceException at Verse.Pawn_AgeTracker.AgeTickInterval`. The test
colony's saved colonists carry state that needs the Ideology DLC, and without it the game throws on every tick; the
scenarios that do not tick (the four that only read defs) passed. So the pass without Ideology cannot play the
whole suite on this fixture. It plays `12-launch-gizmo.feature` only, which is written so that no tick runs, and the
other scenarios are played in full by the two passes with every DLC.
