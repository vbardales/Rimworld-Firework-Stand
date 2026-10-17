# Testing Firework Stand in game

Mod written against three things read by decompiling telardo's assembly, two hooks read in game's own source. Since 2026-09-21 real game plays it, through Pickle, in WSL: see "Pickle (Gherkin) suite" below and `STATUS.md` for what ran and what person still must validate. Scenarios below stay reference for what each proves, and for playing one by hand.

File = list of what to look at, in order that finds problems fastest. Each scenario says what it proves, because test whose failure you cannot interpret not worth running.

One half of testing. Other half needs no colony, runs in fifteen seconds:

```
powershell -NoProfile -ExecutionPolicy Bypass -File Tests/Run-Functional-Tests.ps1
```

Those 33 tests (2026-10-02, all passing) read off compiled game, and off telardo's assembly, that things mod delegates to still do what it delegates them for - virtual slot job driver grafts onto, `IThingGlower` veto light rests on, method and field bridge reaches for by name. Run first: faster than building stand, and failure there explains scenario below before you see it fail. Cannot tell whether colonist walks over and looks up, which is what everything after this line is for.

## Before anything

Audit 2026-09-13: existing 25 automated tests passed against shipped DLL and installed game/dependency. All four mod XML files also passed XML check (now shared `scripts/Check-ModBasics.ps1` and `scripts/Check-Translations.ps1` of protocols repository, since 2026-10-11), including GitHub description link and EN/FR translation keys/placeholders. Run that additional check with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ..\scripts\Check-ModBasics.ps1 -Mod FireworkStand
```

Nine scenarios below written before any run; Pickle suite below now plays them.

1. Fireworks (telardo, `2922179297`) must be subscribed and active, this mod must load after it. Both already declared in `About.xml`; mod list says so.
2. **Stand hidden until `IEDs` researched.** RimWorld does not grey out building with unfinished research, omits it from Architect menu entirely. Fresh colony: menu looks empty, nothing wrong. Dev mode → `Finish all research`, or play until Electricity then IEDs.
3. Build one stand **under open sky**, load with firework launchers. Takes ten, will not fire on empty rack.
4. Architect category is **Recreation**.
5. Keep `Player.log` after session. Anything mod complains about prefixed `[Firework Stand]`.

Salvo goes up every 900 ticks, about twenty-two in-game minutes. Normal speed = long wait for one data point; run at speed 3.

## 1 — The defs exist at all

**Proves** guarded patch matched, precondition for every other scenario.

Open Architect menu, Recreation. Firework stand listed, 40 steel and 20 wood. Then check recreation type itself arrived: colonist's Needs tab, recreation tolerance, should show `fireworks` entry once they watched once.

**If it fails**, patch never applied, nothing else in file can pass. Guard is `Defs/ThingDef[defName="FireworkLauncher"]`, so cause is Fireworks not loading, not anything here.

## 2 — The bridge resolves

**Proves** `Fireworks.CompLaunchFireworks`, its `Launch` method and `launched` field all found by reflection.

Search `Player.log` for `[Firework Stand]`. **Silence is the pass.** Two failures possible, say different things:

- *"Fireworks found, but CompLaunchFireworks.Launch or its launched field could not be resolved"* — telardo changed his class since read. Names to re-check in `FireworksBridge.cs`.
- *"could not bridge to Fireworks"* — lookup itself threw, message carries reason.

**Negative test matters as much.** Disable Fireworks, start again: mod must load in silence, add no building, produce no red error. Whole point of guard.

## 3 — The stand fires more than once

**Proves** rearming, single mechanism mod built on: telardo's comp sets own `launched` field true so only fires once, this mod sets it back to false before each salvo. If not working, stand is very expensive one-shot.

Send colonist to watch, wait out two full intervals, count rockets. **Two or more is pass.** One rocket then nothing, while fuel remains and colonist still watching, is failure — means field no longer public, no longer named `launched`, or no longer what gates the shot.

## 4 — The light comes on, and goes off again

**Proves** `IThingGlower` veto, failure player would notice first.

Test at night, indoors lights off, camera on stand.

- Loaded, idle stand throws **no light at all**.
- At instant rocket leaves, ground around it lights warm for about four seconds.
- Then dark again.

**If stand glows permanently**, veto not consulted: `CompGlower.ShouldBeLitNow` meant to poll every comp implementing `IThingGlower` and give up when one says no. Assumption to re-check first, nothing else in mod depends on it, most visible possible defect.

**If never lights**, `UpdateLit` not reaching light grid, or `flashTicks` elapsed before light registered.

## 5 — Fuse smoke, then the launch

**Proves** two effects that are mod's own contribution, not telardo's.

Watch foot of stand in the second between order and rocket. Thin trail of smoke should rise, then thick puff, sparks and flash as rocket leaves.

Failure here cosmetic, but not left: owner found smoke invisible on first run (2026-09-24), fixed until capture shows it (0.1.1, `STATUS.md`). Red scenario to replay green before publication.

## 6 — Colonists go on their own

**Proves** `JoyGiverDef`, and parts that differ from vanilla watching.

Leave colony idle with recreation need falling, order nothing.

- Colonist walks to stand by themselves, as recreation.
- They stop **4 to 12 cells away**, not next to it.
- They **stand**. Must not drag chair out or look for one: `desireSit` false.
- Several can watch at once, up to ten.

Then build second stand **under a roof**, confirm never used: `unroofedOnly` refuses it, same field vanilla telescope uses.

## 7 — Fuel, and what the inspect line says

**Proves** refuelable wiring, where mod deliberately departs from usual setup: `fuelConsumptionRate` zero, comp removes one rocket per salvo instead.

Count rockets against fuel gauge: **one launcher per salvo, no drain while idle.** Run to zero, confirm stand stops firing and says `No fireworks loaded`.

Read inspect line between salvoes. Should count down (`Reloading: …`) then read `Ready to fire`.

> Fixed in 0.1.1 (read `Ready to fire` even on empty rack, because it reported interval not fuel): line now says nothing when nothing loaded, refuelable gauge says so right beside it.

## 8 — Save and reload mid-cycle

**Proves** `PostExposeData`, four fields.

Save while light on, or just after salvo. Reload.

- Stand does not fire again immediately: reload timer survived.
- Light not stuck on.
- No error on load about missing comp.

## 9 — Only those who could see it get the memory

**Proves** filter added 2026-09-11, the one scenario where correct result is that *nothing* happens.

Set up three colonists while salvo goes off: one outdoors near stand, one **asleep in roofed bedroom** within twelve cells, one awake but indoors under roof.

**Only colonist outdoors gains memory.** Check each one's Needs tab, mood, for `beautiful fireworks` or whichever outcome rolled.

Before this change, all three received it, contradicting mod's own claim that show exists only for whoever is watching. Three filters: awake, under open sky, capable of sight. Deliberately **no ground line-of-sight test** — burst is in the air, so wall between colonist and stand does not hide it, colonist behind that wall should still get memory. If that colonist gets nothing, check become too strict.

## Translation checks (English and French)

Repeat UI checks in both languages, restarting after changing language. Inspect Architect entry and description, recreation tolerance entry, watching job report, loaded and empty fuel messages, ready/reloading inspect lines (including formatted time). Check launcher name and description and all four mood memories and descriptions. Without Ideology, check inherited launch gizmo label and tooltip; with Ideology absent by design. Check for raw keys, English fallback in French, broken accents, paragraph breaks, clipped text. Also load without Fireworks, check for translation load errors. Record languages, dependency version, observed screens, log results in STATUS.md. These checks not yet performed in game.

## Pickle (Gherkin) suite: the scenarios above, played by the game, for a person to validate

Written 2026-09-21 in `Tests/Pickle/`, so scenarios 1 to 9 can be validated by looking at captures and films instead of playing. Each stages situation with game's real jobs and comps, asserts what it can before each capture, records capture; README there says what person looks at for each. Read tag before colour: `@review` asserts nothing about image.

| Scenario above | Pickle feature | What a person validates |
| --- | --- | --- |
| 1 defs exist | `01-loads` | nothing to look at: asserted |
| 2 the bridge resolves | `02-stand-on-map` | asserted (no warning once the inspect pane asked) |
| 2 negative half, Fireworks absent | none | **not applicable, and why:** a hard dependency, so the game never activates the mod without it; the guard is proved outside the game (see below) |
| 3 fires more than once | `03-firing` | film: two rockets, a watcher standing back |
| 4 the light | `05-light` | film and stills: dark, warm for a few seconds, dark |
| 5 fuse smoke, then the launch | `06-fuse-and-launch` | film and stills (cosmetic) |
| 6 goes on their own | `07-on-their-own` | film: unprompted, standing; a roofed stand is refused (asserted) |
| 7 fuel and the inspect line | `08-fuel` | still: what the empty stand's inspect line says beside its gauge |
| 8 save and reload mid-cycle | `09-save-reload` | film; count, timer and light asserted |
| 9 who gets the memory | `10-audience` | still of the layout; who has the memory asserted |
| "before anything" 2, the stand is hidden until IEDs | `13-architect-menu` | stills of the Recreation category before and after; visibility asserted |
| translation checks | `04-labels`, `11-inspect-pane` | asserted labels in each language; stills of the inspect pane in each |
| launch gizmo with and without Ideology | `12-launch-gizmo` | still in the pass without Ideology; presence asserted in every pass |

**Passes mod needs: three,** first two playing whole suite (27 scenarios, none `@wip`, none conditional on tag). Declares no optional mod and no incompatibility, so no "with optional mods" pass and none per incompatibility. All on minimal WSL set (Core, the DLC, Harmony, RimLogging, Pickle, Fireworks, the mod):

| Pass | Command |
| --- | --- |
| English, every DLC | `Run-PickleWsl.ps1 -Mod FireworkStand` |
| French | `Run-PickleWsl.ps1 -Mod FireworkStand -Language French` |
| Without Ideology, feature 12 only | `Run-PickleWsl.ps1 -Mod FireworkStand -DepMap wsl-deps.sans-ideology.map -Filter 12-launch-gizmo.feature` |
| Vitrine (the Workshop gallery), feature 14 only | `Submit-PickleRun.ps1 -Mod FireworkStand -DepMap wsl-deps.vitrine.map -Filter 14-gallery` |

**Why third pass plays one feature only.** Fixture save's colonists carry state needing Ideology DLC: without it game throws NullReferenceException in `Pawn_AgeTracker` on every tick, so any scenario running clock fails and launcher kills run (first attempt, 2026-09-24). `12-launch-gizmo` written so no tick runs. Everything else played in full, with Ideology, by first two passes.

**Fourth pass, `vitrine`, not a test of mod.** `14-gallery` produces Workshop gallery in Sanctuary (save `Nelims-tribe`, place `bare-clearing`), tagged `@requires:nelim.pickletools.screenshotstudio`, so other passes count it skipped. Asserts only what makes image worth keeping (stand exists, loaded, salvo happened), every picture taken with camera all the way in; pictures then cropped (`PUBLICATION.md`, "Gallery"). Red scenario here replayed until green like any other.

Three passes filed as Pickle tickets (`Submit-PickleRun.ps1`, one each), keep evidence of each run on disk under `Tests/Pickle/runs/` (ignored by git), write text summary in `docs/runs/`. Two scenarios read game to know what to assert in a pass (`04-labels` reads active language, `12-launch-gizmo` whether Ideology active), so each green in every pass, none skipped.

**Nothing left manual.** One case that cannot be played, Fireworks absent, not a missing test: mod declares Fireworks in `modDependencies`, so no game exists where stand loaded without it. Guard proved where it can be: patch is `PatchOperationConditional` on `FireworkLauncher` (`Run-Functional-Tests.ps1`, `Check-DefInjected.ps1`), reflection bridge read off compiled assembly (`Run-Functional-Tests.ps1`). Audience filter has no line-of-sight test on purpose, so nothing to test.

**Status (2026-09-25).** Reshaped suite (26 scenarios) passed in English and French on 2026-09-23 and 24, on 0.1.0 build. On 0.1.1 build played in English (26 of 27, one failure a bug of smoke step, fixed), in French (same), in pass without Ideology (feature 12, 1 of 1); smoke scenarios replayed after each smoke tuning, final whole-suite passes on last build still to run. Details and evidence policy: `docs/runs/`. Pickle run only shows path ran: does not replace looking, nothing validated by owner yet.


## Evidence to keep

Disk short of space, so run's evidence kept small and only while it still proves something (root `AGENTS.md`, "Test evidence"). Lives on disk in `Tests/Pickle/runs/<date>-<pass>/`, ignored by git; committed is text summary in `docs/runs/`, one file per run and one line per run in `docs/runs/README.md`, never folders.

**Keep, once run read:**

- `summary.json` and `junit.xml`: raw result, tiny. Read `exitReason` before counts.
- Stills showing something person validates, **minified to jpeg** (ffmpeg: about 0.2 MB instead of 3.5 MB, still readable at 1920x1080): audience, stand loaded and reloading, empty stand beside gauge, fuse and puff, night stills, blueprint, Architect menu, launch gizmo.
- Films of filmed scenarios (`03-firing`, `05-light`, `06-fuse-and-launch`, `07-on-their-own`, `09-save-reload`): already small.
- For pass in second language or without Ideology, captures that differ from first pass, only those.

**Delete:** log and messages file (failure's message in `junit.xml` and summary), contact sheets and half-size copies, any still carrying film's corner frame or made obsolete by later suite change, still repeating another, every report for build or suite revision a newer run replaced.

**Per scenario, keep latest report for revision now in repository**, plus older one only if sole proof of check latest run did not repeat. Delete superseded evidence as soon as newer report read, write in run's `docs/runs/` summary what kept and deleted. Never delete report a `STATUS.md` field still points to: repoint first (STATUS points at `docs/runs/` summaries, not folders).

### What proves what today (audit of 2026-10-02)

Stand code last changed in `7a59b01` (2026-09-28); whole suite last ran on 0.1.1 build of 2026-09-24, before three more smoke tunings and last-rocket fix. Per scenario, report that stands:

| Evidence on disk (`Tests/Pickle/runs/`) | Proves | State |
| --- | --- | --- |
| `2026-09-24-english` (junit, summary, 11 stills) | features 01 to 13 in English, 0.1.1 first build | sole proof of those scenarios: **non-regression** pass still to rerun on the final build |
| `2026-09-24-french-0-1-1` (junit, summary, stills) | the same in French | same |
| `2026-09-24-sans-ideology` (junit, summary) | feature 12 without Ideology | same, sole proof of that check |
| `2026-09-25-smoke-4` (junit, summary, 2 stills) | the fuse smoke is visible | validated by the owner as a principle |
| `2026-09-28-vitrine-11` (junit, summary, 9 images) | feature 14, the gallery, green on the final mod code | the only report on the current revision; the source of the Workshop gallery |

**Order of passes (owner's rule, 2026-10-02).** What never ran or is red replayed alone, in small tickets (`-Filter` on feature). Nothing in that state now: every scenario has green run. Whole-suite passes (English, French, without Ideology) rerun what already green, so filed **all together, at end, on final revision**; change to stand or step they use makes scenario new again. Scenarios `05-light` and `06-fuse-and-launch` changed after last whole-suite run (last-rocket fix, smoke tunings): first to replay if short pass wanted before end.

**What evidence keeps, to write down at every test (so nobody guesses later).** Per scenario, latest `junit.xml` and `summary.json` of revision now in repository, and stills person validates (listed in "Evidence to keep" above). Older report stays only while sole proof of check newest run did not repeat. Film never stays: junit already says scenario ran, film proves nothing still does not.

**Gates for `tested` (AUDIT.md, transition 9, 2026-10-02).** (1) no scenario in `@wip`: met, none in suite; (2) every conditional scenario has run: none conditional on `@requires:<packageId>` tag, mod declares no optional mod, DLC or companion tool, pass without Ideology only condition-dependent one (has run); (3) no manual test left to validate: nothing manual (Fireworks absent not applicable, justified above). `@review` captures still to be looked at by owner. Three whole-suite passes on final build = non-regression pass, filed last.

## Publishing gate

Scenarios 1 to 4 and 8 gate publishing: cover patch, bridge, rearming, light, save. 5, 6, 7 and 9 behaviour worth getting right but defect in them is patch note, not blocker.