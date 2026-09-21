# In-game scenarios, run by Pickle

The scenarios of [TESTING.md](../../TESTING.md) that a running game is needed for, and only those.
`Mod/` is a companion mod, **Firework Stand - Pickle tests**, never published. It holds four feature
files and nothing else: every step is Pickle's own generic vocabulary, so there is no companion
assembly to build.

**Status: the English pass ran once, on 2026-09-21 at 19:07 in the WSL under Xvfb; the French pass
has not run.** The suite was written that day so that `preTest -> done` is met; running it belongs
to `done -> tested`.

English pass (`sans-facultatifs`), report kept in [`runs/2026-09-21-english/`](runs/2026-09-21-english/):
4 features discovered, 11 scenarios, **8 played and passed, 0 failed, 3 skipped (the three `@wip`
ones, as designed), `exitReason: passed`, exit code 0.** All 12 staged mods loaded. The one
`@review` capture (`firework-stand-empty.png`) was opened: the stand is on the map, drawn from
Fireworks' launcher texture, in daylight, with the interface showing (this is a review capture, not
a publication shot).

What that run does **not** show:

- **The bridge was probably never asked.** `FireworksBridge` resolves lazily, on the first read of
  `Available`, and nothing in the played scenarios read it (no colonist watched, no inspect pane was
  opened). The "no `Firework Stand]` warning" assertions of that run are therefore vacuous about the
  bridge. A scenario that selects the stand and reads its inspect line was added to
  `02-stand-on-map.feature` **after** the run and has not been played.
- The log holds one `ERROR`, "Mod Firework Stand - Pickle tests did not load any content", and one
  warning that the companion's dependency lacks a `steamWorkshopUrl`. Both come from the companion
  mod having no content folders and appear in the same shape in the Adaptive Storage companion's log;
  neither comes from the mod under test. `no errors were logged` passed regardless.
- Green shows that the path ran, not that the mod works: the stand was never loaded, never watched
  and never fired.

Each step was matched against the step expressions compiled into `RimWorks.Pickle.Vanilla.dll`
(Workshop 3791648678) before the run; the run found no undefined step among the eight it played.

## Scope: what stays in Gherkin, and what does not

Everything provable outside the game is proved outside it, by `_tools/Run-Functional-Tests.ps1`
(25 tests: the vanilla driver slot the job graft takes, the `IThingGlower` veto, the reflection
bridge into Fireworks, the def-to-class and setting contracts) and `_tools/Test-Xml.ps1`, in
seconds. None of those claims is repeated here.

| Feature | What only a running game shows | TESTING.md |
| --- | --- | --- |
| `01-loads` | The guarded patch matched in the game's real patch pipeline: the stand, the recreation type, the job and the joy giver exist, the stand points at its own recreation type, English labels, and a save loads without an error or a `[Firework Stand]` warning. | 1, 2 |
| `02-stand-on-map` | A stand placed on a map ticks without an error, survives a save and a reload, and one capture (`@review`) shows it as the player sees it. A fourth scenario, added after the run, selects the stand so that the bridge is really asked (see Status). | 2, 8 |
| `03-watching` (`@wip`) | A colonist with a low recreation need goes to the stand by themselves. Written as a hypothesis, see the file header: two guesses the steps cannot settle. | 6 |
| `04-french-names` (`@wip`) | In a French game, the stand, its recreation type and the reused launcher are French. | translation |

**Deliberately not in Gherkin**, with the reason, so nobody adds a scenario that cannot work:

- **Scenario 2, Fireworks absent.** Fireworks is a hard dependency; the game will not load this mod
  without it, so there is no game to play. Manual.
- **Scenarios 3, 4, 5 and 7: repeat firing, the light, the smoke, the fuel count.** They need the
  stand loaded with launchers and a colonist watching it, and no vanilla step loads a refuelable or
  reads a comp field. A companion assembly with custom steps would be needed, and it would be
  written against guesses about `CompFireworkStand`'s internals. Manual until that is worth its cost.
- **Scenario 9, the mood audience filter.** It needs a salvo fired on demand and three colonists in
  three states; the correct result is that nothing happens to two of them. Manual.
- **The reload timer surviving a save** (scenario 8, first bullet). Needs a comp field read. Manual.
- **The inherited launch gizmo with and without Ideology.** The WSL staging mounts every DLC, so a
  no-Ideology pass cannot be staged. Manual.

## Passes

The mod declares no optional mod (`loadAfter` names only RimWorld and Fireworks) and no
incompatibility, so there is no pass with optional mods and no pass per incompatibility. It needs
**two passes**, both on the minimal set that `scripts/stage-pickle-wsl.sh` mounts by default (Core,
the DLC, Harmony, RimLogging, Pickle, Fireworks, the mod and its companion):

| Pass | Command | Plays |
| --- | --- | --- |
| English, `sans-facultatifs` | `powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod FireworkStand` | features 01 and 02 (the `@wip` ones are skipped) |
| French | `powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod FireworkStand -Language French -Filter '04-french-names.feature' -IncludeWip` | feature 04 |

Feature 03 has a pass of its own, once someone has read the vanilla joy giver and decided whether an
empty stand is offered: `-Filter '03-watching.feature' -IncludeWip`. Until then it is not counted
among the scenarios a pass must play.

`wsl-ids.map` gives the staging Fireworks' Workshop id (2922179297), which the script's built-in
table does not know. Whether steamcmd can download that item anonymously was not checked.

Running any of this takes the machine lock and is done only through `scripts/Run-PickleWsl.ps1`;
see `scripts/PICKLE-WSL.md`. Read `exitReason` before the counts, compare the scenarios played with
the features discovered, and open the `@review` capture: a green run does not show that the picture
shows anything.
