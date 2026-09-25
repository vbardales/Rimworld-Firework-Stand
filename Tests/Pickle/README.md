# In-game scenarios, run by Pickle

The scenarios of [TESTING.md](../../TESTING.md) that a running game is needed for, and only those.
`Mod/` is a companion mod, **Firework Stand - Pickle tests**, never published. It holds the feature
files and a small step assembly (`Source/`, built into `Mod/Pickle/Assemblies/`), so nothing
test-related ships in the Workshop folder.

**The point of this suite: a person validates captures and films, and does not have to play the
scenarios.** Each scenario stages the situation, makes the game do the thing through the real job
and the real comps, asserts what it can (before each capture, so the image is worth opening) and
takes the capture or the film. Read the tag before the colour: `@review` asserts nothing about an
image, and a green scenario says the trajectory ran, not that the picture shows anything.

## Status

Updated 2026-09-25. The history of every run is in [`docs/runs/`](../../docs/runs/README.md), one text line per run.

- **The reshaped suite** (27 scenarios in 13 features, none `@wip`, three passes) passed 26 of 26 in English (2026-09-23)
  and in French (2026-09-24) on the **0.1.0** build.
- **On the 0.1.1 build** (the empty stand gives no recreation and no "Ready to fire"; the fuse smoke fixed in three steps,
  see `CHANGELOG.md`): English ran 26 of 27, French 26 of 27, the one failure in both a bug of the smoke step, since fixed;
  the pass without Ideology (feature 12 only) passed 1 of 1. The smoke scenarios are replayed after each tuning of the smoke;
  the final whole-suite passes on the last build are still to run.
- **Nothing has been validated by the owner yet**: a run shows that the path ran, not that an image shows anything.
- The English report of 2026-09-21 20:28 was lost before it was read (a failure of unknown cause). The English pass of
  2026-09-23 and later ones are green on every scenario the 0.1.0 suite had.
## The features

| Feature | What it stages | Assertions before the capture | Capture |
| --- | --- | --- | --- |
| `01-loads` | the game's real patch pipeline | the stand, recreation type, job and joy giver exist; the stand points at its recreation type; a save loads with no error or `Firework Stand]` warning | none |
| `02-stand-on-map` | a stand built on the map | ticks 300 without error, survives a save and reload; selecting it resolves the bridge without a warning | 2 stills |
| `03-firing` | a real watcher, 3 launchers | watching, 4 to 12 cells away, no chair; count goes 3 → 2 → 1, one salvo each, at the stand's own interval | **film** |
| `04-labels` | the active language | the stand, its recreation type and the reused launcher carry the labels of the language of the pass (English or French) | none |
| `12-launch-gizmo` | a launcher on the ground | Fireworks' launch gizmo is offered exactly when Ideology is inactive | 1 still |
| `13-architect-menu` | the research IEDs unfinished, then finished | the Recreation category hides the stand, then lists it | 2 stills |
| `05-light` | night, a loaded stand, a watcher | light off before, on when the rocket leaves, off again | **film**, and a non-filmed twin with 3 stills |
| `06-fuse-and-launch` | closest zoom on the stand | a launcher was spent (the fuse was lit); at least 4 smoke puffs are near the stand 40 ticks in | **film**, and a non-filmed twin with 2 stills |
| `07-on-their-own` | a bored colonist, no order | picks the stand by themselves, watches it standing, 4 to 12 cells away; a roofed stand and a stand with nothing loaded are never used | **film** |
| `08-fuel` | a stand nobody watches; a last launcher | nothing drains while idle; the last launcher is spent, nothing more happens, and the watcher has stopped watching | 1 still |
| `09-save-reload` | a save taken while the light is on | count and timer survive (no refire for 300 ticks), the light does not stay on, no error | **film** |
| `10-audience` | four colonists: a watcher, one outdoors, one asleep under a roof, one awake under a roof | the outdoor one gains a fireworks memory, the other two do not; all in their intended state first | 1 still |
| `11-inspect-pane` | the stand loaded, then reloading; a blueprint | none on wording | 3 stills, in the language of the pass |

Everything runs unchanged in English and in French: no step spells a translated word, the stand is
selected by where it stands, and a button is never named. The two passes differ only in what the
captures show, which is what a person looks at (a raw key, English left in French, a clipped line).

## What a person looks at

| Capture | The one question |
| --- | --- |
| `03-firing` film | Do two rockets go up, the second about 900 ticks after the first, with a watcher standing well back? |
| `05-light` film and stills | Is the ground dark before, warmly lit for a few seconds when the rocket leaves, dark after? Is it a lamp, or a flash? |
| `06-fuse-and-launch` film | Does a thread of smoke rise from the foot of the stand before the launch, then a thick puff and sparks? (Cosmetic, not a gate.) |
| `07-on-their-own` film | Does the colonist walk over unprompted and stand, not sit? |
| `08-fuel` still | On the empty stand, what does the inspect line say beside the gauge? (Since 0.1.1: the count and "No fireworks loaded", no "Ready to fire".) |
| `09-save-reload` film | Is the stand, right after the reload, as the save left it? |
| `10-audience` still | Is the layout what the scenario says: the stand, one colonist in the open, the roofed patch with the other two? |
| `11-inspect-pane` stills, both languages | Any raw key, fallback, broken accent, clipped line, wrong paragraph break, badly formed time in the reload line? Is the blueprint the stand, and named in the language of the pass? |
| `12-launch-gizmo` still, in the pass without Ideology | Is the launch gizmo there beside the selected launcher, with a label and a tooltip in the language of the pass? (Absent, as designed, in the other two passes.) |
| `13-architect-menu` stills | Does the Recreation category show no stand before IEDs and the stand after it? Is the entry named in the language of the pass? |

## Scope: what stays out of Gherkin, and why

Everything provable outside the game is proved outside it, by `_tools/Run-Functional-Tests.ps1`
(32 tests) and `_tools/Test-Xml.ps1`. None of that is repeated here. **No scenario is `@wip`, no test is left
for a person to play**: what a person does is validate captures and films.

- **Fireworks absent (TESTING.md scenario 2, negative half): not applicable, and why.** Fireworks is a hard
  dependency declared in `About.xml`, so the game does not activate this mod without it; there is no running game
  in which the stand is loaded and Fireworks is not. What remains true of that case is the guard itself, and it is
  proved outside the game: the patch is a `PatchOperationConditional` on `FireworkLauncher` (`Test-Xml.ps1` and
  `Check-DefInjected.ps1`), and the reflection bridge is read off the compiled assembly (`Run-Functional-Tests.ps1`).
- **No line-of-sight test in the audience filter.** Deliberate in the mod, so there is nothing to test; proving its
  absence would need a wall and a pawn behind it and would assert what the mod chose not to do.
- **The mood tab of a colonist.** The memory is asserted by def, not read off the tab.

Two things that were manual are now scenarios: the inherited launch gizmo with and without Ideology
(`12-launch-gizmo`, played in the pass that leaves the DLC out) and the Architect menu entry, hidden until IEDs is
researched (`13-architect-menu`).

## What the vanilla joy giver was read to say

`JoyGiver_WatchBuilding` and `JoyGiver_InteractBuilding` were read from the compiled game on
2026-09-21. They offer a building that can be reserved, is not forbidden, not fogged, socially proper,
not under vacuum, powered if it has a power comp, and unroofed when the def says `unroofedOnly`. They
**never look at fuel**: an empty stand is offered as recreation. The driver's joy tick is vanilla's and
does not ask the stand either, so a colonist watching an empty stand gains full fireworks recreation
without a rocket going up. That was the 0.1.0 behaviour; the owner decided an empty stand gives no recreation, and 0.1.1 has
its own joy giver and driver that refuse it (`07-on-their-own` and `08-fuel` assert it).

## Passes

The mod declares no optional mod (`loadAfter` names only RimWorld and Fireworks) and no
incompatibility, so there is no pass with optional mods and none per incompatibility. It needs
**three passes**, the first two playing the **whole suite** (27 scenarios) and the third one feature (`12-launch-gizmo`, see below), on the minimal set that
`scripts/stage-pickle-wsl.sh` mounts (Core, the DLC, Harmony, RimLogging, Pickle, Fireworks, the mod and its
companion). No scenario is conditional on a tag: the two that depend on the pass read the game and assert the
value for it (`04-labels` reads the active language, `12-launch-gizmo` reads whether Ideology is active), so each
is green in every pass and none is skipped.

| Pass | Command | What differs |
| --- | --- | --- |
| English, `sans-facultatifs` | `powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod FireworkStand` | every DLC active, Ideology included: the launch gizmo must be absent |
| French | `powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod FireworkStand -Language French` | the labels are French, and the captures show the French interface |
| Without Ideology | `powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod FireworkStand -DepMap wsl-deps.sans-ideology.map -Filter 12-launch-gizmo.feature` | `!ludeon.rimworld.ideology` leaves the DLC out: the launch gizmo must be there |

**`Run-Passes.ps1` plays the three in turn** (`powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Run-Passes.ps1`).
It goes through the launcher for each (ticket, lock, staging, release) and, the moment the launcher returns, copies
what the run wrote into `runs/<date>-<pass>/` (summary, junit, log, this suite's films and stills), **on disk and ignored by git**, and
writes a text summary of the run in `docs/runs/<date>-<pass>.md`, which is what is committed. It keeps only files this suite
names (the screenshots folder is shared and accumulates) and does not stop the next pass if one copy fails. The first English
run of this suite lost its report because nobody was there to copy it; this is there.

`wsl-ids.map` gives the staging Fireworks' Workshop id (2922179297); the run of 2026-09-21 showed the staging finds it.

Running takes the machine lock and is done only through `scripts/Run-PickleWsl.ps1`; see
`scripts/PICKLE-WSL.md`. Read `exitReason` before the counts, compare the scenarios played with the
features discovered, and open the captures. Copy what you need out of the report before the next
launch: the archive is a reprieve, not storage.

## Build

```powershell
dotnet build Tests/Pickle/Source/FireworkStand.PickleSteps.csproj -c Release
```

The output goes to `Mod/Pickle/Assemblies/` and is committed: the staging mirrors that folder as it
is. The assembly references the game and Pickle only, not the mod under test.

## What the first two runs taught about captures

- **A screenshot taken while a film is recording is polluted.** The film's own 480x270 frame lands in
  the bottom-left corner of the still, over the real picture. Six of the sixteen stills of the French
  run were spoilt that way (the ones taken inside filmed scenarios). The suite now films without
  stills and takes the stills in a twin scenario that is not filmed.
- **Each film opens with about five seconds of the main menu**, the save loading, then the game at
  the closest zoom, which at the film's 960x540 makes the stand small. The stills are the better
  evidence for detail; the films are for movement.
- **In a French game the inspect pane of the empty stand read "Prête à tirer" beside a gauge at 0 / 10** on the 0.1.0 build:
  fixed in 0.1.1 (the pane now says only the count and that nothing is loaded, checked on the captures of both languages).
- **The blueprint capture shows the ghost of the stand, not its watching area.** The area is drawn
  while placing or selecting, not around a blueprint that is already down; the scenario title no
  longer claims otherwise.

## Evidence

What to keep after a run, and what to delete, is in [`TESTING.md`](../../TESTING.md), "Evidence to keep": the raw result
and the stills and films that show something, minified, on disk and out of git; a text summary in `docs/runs/`; the rest
deleted as soon as a newer report replaces it.

## Why the pass without Ideology plays one feature

The first attempt (2026-09-24) played the whole suite without the DLC and died: the fixture save's colonists carry state
that needs Ideology, and without it the game throws a `NullReferenceException` in `Pawn_AgeTracker.AgeTickInterval` on
every tick, so every scenario that ran the clock failed and the launcher killed the run as stalled. `12-launch-gizmo`
runs no tick (nothing waits), so it is the one feature played there, and `Run-Passes.ps1` names it with `-Filter`. This is
not a conditional scenario: the whole suite is played, with Ideology, by the first two passes.

## Queue: hand it to the TicketDispatcher, follow nothing

The Pickle queue is followed by the TicketDispatcher, not by this suite: no monitor, heartbeat, cron or loop of ours. Since
2026-09-24 the passes are submitted with `Rimworld-Ticket-Dispatcher/scripts/Submit-PickleRun.ps1` (one request per pass,
`-EvidenceDir` under `Tests/Pickle/runs`), and the dispatcher wakes the session with START, END and RUN_DONE; see
`Rimworld-Ticket-Dispatcher/docs/WELCOME.md`. The three requests, all on the 0.1.1 build: English (whole suite), French (whole
suite), and without Ideology (`-DepMap wsl-deps.sans-ideology.map -Filter 12-launch-gizmo.feature`). `Run-Passes.ps1` is the
direct route it replaced; it is kept only for what it knows about this suite's evidence (which stills and films are ours) and
is not run any more.
