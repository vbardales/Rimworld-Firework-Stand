# Pickle run: without Ideology, feature 12 only, 2026-09-24 (the second attempt)

- **exitReason:** `passed`. Launcher exit code 0. Through the TicketDispatcher (request e077), `-DepMap wsl-deps.sans-ideology.map`, `-Filter` on feature 12.
- **Scenarios:** 1 discovered, 1 passed, 0 failed.
- **Scenario:** a launcher on the ground offers its launch gizmo only without Ideology, Passed, 37975 ms. No tick runs in it (the fixture colony throws on every tick without Ideology, see `2026-09-24-sans-ideology.md`).
- **What it shows:** with Ideology absent from the mod list, the stand's launcher offers the launch gizmo, which telardo's mod withholds when Ideology is active; the two passes with every DLC assert it absent. It is the only thing the pass without Ideology is for.
- **Evidence, on disk and ignored by git, trimmed:** `Tests/Pickle/runs/2026-09-24-sans-ideology/` keeps `summary.json` and `junit.xml`; the html report, the log and the messages file are deleted. No screenshot: the scenario takes none.
- **Build:** the first 0.1.1 build; the gizmo does not depend on the fuse smoke, so it is not affected by what came after, but the final pass reruns it on the last build.
