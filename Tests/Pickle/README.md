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

- **English pass, 2026-09-21 19:07** (the first four features only, before this suite was widened):
  8 of 8 non-`@wip` scenarios passed, `exitReason: passed`. Report in
  [`runs/2026-09-21-english/`](runs/2026-09-21-english/). That run did not exercise the bridge to
  Fireworks (it resolves lazily and nothing read it); `02-stand-on-map` now selects the stand, which does.
- **The widened suite has never been run.** Features `03` and `05` to `11` and the step assembly were
  written afterwards. Each step was matched against the expressions compiled into Pickle, the
  features parse with Pickle's own Gherkin parser and the assembly builds, and that is all that can be
  said before a run: a first run may find an undefined step, a wrong cell, or a colonist who chooses
  another recreation.
- The French pass has not run.

## The features

| Feature | What it stages | Assertions before the capture | Capture |
| --- | --- | --- | --- |
| `01-loads` | the game's real patch pipeline | the stand, recreation type, job and joy giver exist; the stand points at its recreation type; a save loads with no error or `Firework Stand]` warning | none |
| `02-stand-on-map` | a stand built on the map | ticks 300 without error, survives a save and reload; selecting it resolves the bridge without a warning | 2 stills |
| `03-firing` | a real watcher, 3 launchers | watching, 4 to 12 cells away, no chair; count goes 3 → 2 → 1, one salvo each, at the stand's own interval | **film**, 2 stills |
| `04-french-names` (`@wip`) | a French game | the stand, its recreation type and the reused launcher read in French | none |
| `05-light` | night, a loaded stand, a watcher | light off before, on when the rocket leaves, off again | **film**, 3 stills |
| `06-fuse-and-launch` | closest zoom on the stand | a launcher was spent (the fuse was lit) | **film**, 2 stills |
| `07-on-their-own` | a bored colonist, no order | picks the stand by themselves, watches it standing, 4 to 12 cells away; a roofed stand is never used | **film**, 1 still |
| `08-fuel` | a stand nobody watches; a last launcher | nothing drains while idle; the last launcher is spent and nothing more happens | 1 still |
| `09-save-reload` | a save taken while the light is on | count and timer survive (no refire for 300 ticks), the light does not stay on, no error | **film**, 1 still |
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
| `08-fuel` still | On the empty stand, what does the inspect line say beside the gauge? (Known rough edge, see STATUS.md.) |
| `09-save-reload` film | Is the stand, right after the reload, as the save left it? |
| `10-audience` still | Is the layout what the scenario says: the stand, one colonist in the open, the roofed patch with the other two? |
| `11-inspect-pane` stills, both languages | Any raw key, fallback, broken accent, clipped line, wrong paragraph break, badly formed time in the reload line? Does the blueprint show its watching area? |

## Scope: what stays out of Gherkin, and why

Everything provable outside the game is proved outside it, by `_tools/Run-Functional-Tests.ps1`
(25 tests) and `_tools/Test-Xml.ps1`. None of that is repeated here.

- **Scenario 2, Fireworks absent.** A hard dependency: the game will not load this mod without it,
  so there is no game to play. Manual.
- **The inherited launch gizmo with and without Ideology.** The WSL staging mounts every DLC, so a
  no-Ideology pass cannot be staged. Manual.
- **The Architect menu entry.** No step opens a menu category without naming a translated button.
  The blueprint scenario proves the stand can be placed through the game's own designator, not that
  the menu lists it.
- **No line-of-sight test in the audience filter.** Deliberate in the mod; proving it needs a wall
  and a pawn behind it. Not written.
- **The mood tab of a colonist.** The memory is asserted by def, not read off the tab.

## What the vanilla joy giver was read to say

`JoyGiver_WatchBuilding` and `JoyGiver_InteractBuilding` were read from the compiled game on
2026-09-21. They offer a building that can be reserved, is not forbidden, not fogged, socially proper,
not under vacuum, powered if it has a power comp, and unroofed when the def says `unroofedOnly`. They
**never look at fuel**: an empty stand is offered as recreation. The driver's joy tick is vanilla's and
does not ask the stand either, so a colonist watching an empty stand gains full fireworks recreation
without a rocket going up. That is a design question recorded in STATUS.md, not something a scenario
asserts.

## Passes

The mod declares no optional mod (`loadAfter` names only RimWorld and Fireworks) and no
incompatibility, so there is no pass with optional mods and none per incompatibility. It needs
**two passes**, both on the minimal set that `scripts/stage-pickle-wsl.sh` mounts (Core, the DLC,
Harmony, RimLogging, Pickle, Fireworks, the mod and its companion):

| Pass | Command | Plays |
| --- | --- | --- |
| English, `sans-facultatifs` | `powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod FireworkStand` | features 01, 02, 03, 05 to 11 (19 scenarios); `04` is `@wip` and skipped |
| French | `powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod FireworkStand -Language French -IncludeWip` | the same 19 plus feature 04 (2 more), all in French |

`wsl-ids.map` gives the staging Fireworks' Workshop id (2922179297); the English run of 2026-09-21
showed the staging finds it.

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
