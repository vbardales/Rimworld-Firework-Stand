# Pickle run: English, first four features, 2026-09-21 19:07

- **exitReason:** `passed`. Launcher exit code: 0.
- **Scenarios:** 11 discovered, 8 passed, 0 failed, 3 skipped (the three `@wip` ones, since removed), 0 flaky.
- **Set name:** `sans-facultatifs`.
- **Evidence:** deleted on 2026-09-23, superseded: the suite was reshaped, and its one capture (the empty stand) is also in the French run. It remains in git history, commits 9e7718b to db09abe.
- **Validated by a person:** the one capture, `firework-stand-empty.png`, was opened by the session that ran it: the stand
  is on the map in daylight, drawn from Fireworks' launcher texture. Not validated by the owner.

This run did not exercise the bridge to Fireworks, which resolves lazily and nothing read: its "no warning"
assertions say nothing about the bridge. The suite was reshaped afterwards.

| Scenario | Outcome | Duration (ms) | Attempts | Mean tick (ms) |
|---|---|---|---|---|
| the mod is active and loads after Fireworks | Passed | 433 | 1 |  |
| the guarded patch added the stand, the recreation type, the job and the joy giver | Passed | 341 | 1 |  |
| the stand is tied to its own recreation type | Passed | 99 | 1 |  |
| the stand reads in English | Passed | 174 | 1 |  |
| loading a game with the mod raises no error and no warning of its own | Passed | 11824 | 1 |  |
| a stand can be built and left running | Passed | 8825 | 1 | 1.131 |
| a stand survives a save and a reload | Passed | 24016 | 1 | 1.135 |
| the stand as the player sees it, empty | Passed | 7392 | 1 | 0.75 |
| an idle colonist with a low recreation need watches the stand | Skipped | 0 | 1 |  |
| the stand and its recreation type are French | Skipped | 0 | 1 |  |
| the dependency's launcher, translated by this mod, is French | Skipped | 0 | 1 |  |
