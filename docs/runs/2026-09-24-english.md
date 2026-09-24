# Pickle run: english, 2026-09-24-english

- **exitReason:** `watchdog-timeout` (read before the counts). Launcher exit code: 3.
- **Scenarios:** 5 discovered, 5 passed, 0 failed, 0 skipped, 0 flaky.
- **Set name:** ``.
- **Evidence:** deleted (a run cut short at 5 of 27 scenarios proves nothing about the rest); the relevant log lines are quoted below.
- **Validated by a person:** not yet. A green scenario shows the trajectory ran, not that an image shows anything.

| Scenario | Outcome | Duration (ms) |
| --- | --- | --- |
| the mod is active and loads after Fireworks | Passed | 3456 |
| the guarded patch added the stand, the recreation type, the job and the joy giver | Passed | 643 |
| the stand is tied to its own recreation type | Passed | 211 |
| loading a game with the mod raises no error and no warning of its own | Passed | 76211 |
| a stand can be built and left running | Passed | 34908 |

## What happened (first pass on the 0.1.1 build)

The run stopped at the sixth scenario, `a stand survives a save and a reload`, on its step `When I save and reload`: Pickle's
watchdog tripped after 120 s ("watchdog forcing exit, code 2", then "Environment.Exit did not end the process,
force-killing"), and the RimWorld process outlived its own kill for a while, with the dashboard on port 27750 no longer
answering, as another session reported. The log's last lines are the second `Loading game from file __pickle_roundtrip`
at 08:28:27 and 08:29:12 (game clock), each load taking several seconds of garbage collection, then nothing.

Not established: whether this is the new build or the machine. The same scenario took 21 s on the 0.1.0 build and 31 s
in the French pass, and passed on both; it involves no watcher and none of the changed code is called in it, but the
comp does now run its effects in `CompTick`. The French pass, replayed straight after, is the check: if this scenario
hangs again there, the new build is the suspect.
