# Testing Firework Stand in game

Nothing in this mod has ever been observed running. It is written against three things read by
decompiling telardo's assembly and two hooks read in the game's own source, and every one of them
is an assumption until a colonist stands in a field and watches a rocket go up.

This file is the list of what to look at, in the order that finds problems fastest. Each scenario
says what it proves, because a test whose failure you cannot interpret is not worth running.

It is one half of the testing. The other half needs no colony and runs in fifteen seconds:

```
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1
```

Those 25 tests read off the compiled game, and off telardo's assembly, that the things this mod
delegates to still do what it delegates them for - the virtual slot the job driver grafts onto,
the `IThingGlower` veto the light rests on, the method and field the bridge reaches for by name.
Run that first: it is faster than building a stand, and a failure there explains a scenario below
before you ever see it fail. What it cannot tell you is whether a colonist walks over and looks
up, which is what everything after this line is for.

## Before anything

Audit 2026-09-13: the existing 25 automated tests passed against the shipped DLL and installed
game/dependency. All four mod XML files also passed `_tools/Test-Xml.ps1`, including the GitHub
description link and EN/FR translation keys/placeholders. Run that additional check with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Test-Xml.ps1
```

The nine scenarios below have not yet been executed in game.

1. Fireworks (telardo, `2922179297`) must be subscribed and active, and this mod must load after
   it. Both conditions are already declared in `About.xml`; the mod list will say so.
2. **The stand is hidden until `IEDs` is researched.** RimWorld does not grey out a building whose
   research is unfinished, it omits it from the Architect menu entirely. On a fresh colony the
   menu will look empty and nothing is wrong. Dev mode → `Finish all research`, or play until
   Electricity then IEDs.
3. Build one stand **under open sky**, and load it with firework launchers. It takes ten, and it
   will not fire on an empty rack.
4. The Architect category is **Recreation**.
5. Keep `Player.log` after the session. Anything this mod complains about is prefixed
   `[Firework Stand]`.

A salvo goes up every 900 ticks, about twenty-two in-game minutes. At normal speed that is a long
wait for one data point; run at speed 3.

## 1 — The defs exist at all

**Proves** the guarded patch matched, which is the precondition for every other scenario.

Open the Architect menu, Recreation. The firework stand is listed, 40 steel and 20 wood.
Then check that the recreation type itself arrived: a colonist's Needs tab, recreation tolerance,
should show a `fireworks` entry once they have watched once.

**If it fails**, the patch never applied and nothing else in this file can pass. The guard is
`Defs/ThingDef[defName="FireworkLauncher"]`, so the cause is Fireworks not loading rather than
anything here.

## 2 — The bridge resolves

**Proves** that `Fireworks.CompLaunchFireworks`, its `Launch` method and its `launched` field were
all found by reflection.

Search `Player.log` for `[Firework Stand]`. **Silence is the pass.** Two failures are possible and
they say different things:

- *"Fireworks found, but CompLaunchFireworks.Launch or its launched field could not be resolved"* —
  telardo changed his class since it was read. The names to re-check are in `FireworksBridge.cs`.
- *"could not bridge to Fireworks"* — the lookup itself threw, and the message carries the reason.

**The negative test matters as much.** Disable Fireworks, start again: the mod must load in
silence, add no building, and produce no red error. That is the whole point of the guard.

## 3 — The stand fires more than once

**Proves** the rearming, which is the single mechanism this mod is built on: telardo's comp sets
its own `launched` field to true so it only ever fires once, and this mod sets it back to false
before each salvo. If it does not work, the stand is a very expensive one-shot.

Send a colonist to watch, wait out two full intervals, and count the rockets. **Two or more is the
pass.** One rocket and then nothing, while fuel remains and a colonist is still watching, is the
failure — and it means the field is no longer public, no longer named `launched`, or no longer
what gates the shot.

## 4 — The light comes on, and goes off again

**Proves** the `IThingGlower` veto, and this is the failure a player would notice first.

Test at night, indoors lights off, camera on the stand.

- The loaded, idle stand throws **no light at all**.
- At the instant a rocket leaves, the ground around it lights warm for about four seconds.
- Then it goes dark again.

**If the stand glows permanently**, the veto is not being consulted: `CompGlower.ShouldBeLitNow`
is meant to poll every comp implementing `IThingGlower` and give up when one says no. That is the
assumption to re-check first, because nothing else in the mod depends on it and it is the most
visible possible defect.

**If it never lights**, `UpdateLit` is not reaching the light grid, or `flashTicks` elapsed before
the light was registered.

## 5 — Fuse smoke, then the launch

**Proves** the two effects that are this mod's own contribution rather than telardo's.

Watch the foot of the stand in the second between the order and the rocket. A thin trail of smoke
should rise from it, then a thick puff, sparks and a flash as the rocket leaves.

A failure here is cosmetic and does not block publishing. Note it and move on.

## 6 — Colonists go on their own

**Proves** the `JoyGiverDef`, and the parts of it that differ from vanilla watching.

Leave a colony idle with recreation need falling and do not order anything.

- A colonist walks to the stand by themselves, as recreation.
- They stop **4 to 12 cells away**, not next to it.
- They **stand**. They must not drag a chair out or look for one: `desireSit` is false.
- Several can watch at once, up to ten.

Then build a second stand **under a roof** and confirm it is never used: `unroofedOnly` is what
refuses it, the same field the vanilla telescope uses.

## 7 — Fuel, and what the inspect line says

**Proves** the refuelable wiring, where the mod deliberately departs from the usual setup:
`fuelConsumptionRate` is zero and the comp removes one rocket per salvo instead.

Count rockets against the fuel gauge: **one launcher per salvo, no drain while idle.** Run it down
to zero and confirm the stand stops firing and says `No fireworks loaded`.

Read the inspect line between salvoes. It should count down (`Reloading: …`) and then read
`Ready to fire`.

> Known rough edge, not a blocker: the line reads `Ready to fire` even on an empty rack, because
> it reports the interval and not the fuel. The refuelable gauge says the truth right beside it.

## 8 — Save and reload mid-cycle

**Proves** `PostExposeData`, four fields.

Save while the light is on, or just after a salvo. Reload.

- The stand does not fire again immediately: the reload timer survived.
- The light is not stuck on.
- No error on load about a missing comp.

## 9 — Only those who could see it get the memory

**Proves** the filter added on 2026-09-11, and this is the one scenario where the correct result is
that *nothing* happens.

Set up three colonists while a salvo goes off: one outdoors near the stand, one **asleep in a
roofed bedroom** within twelve cells, one awake but indoors under a roof.

**Only the colonist outdoors gains the memory.** Check each one's Needs tab, mood, for
`beautiful fireworks` or whichever outcome was rolled.

Before this change, all three received it, which contradicted the mod's own claim that the show
exists only for whoever is watching. The three filters are: awake, under open sky, capable of
sight. There is deliberately **no ground line-of-sight test** — the burst is in the air, so a wall
between colonist and stand does not hide it, and a colonist standing behind that wall should still
get the memory. If that colonist gets nothing, the check has become too strict.

## Translation checks (English and French)

Repeat the UI checks in both languages, restarting after changing language. Inspect the
Architect entry and description, recreation tolerance entry, watching job report, loaded
and empty fuel messages, and ready/reloading inspect lines (including the formatted time).
Check the launcher name and description and all four mood memories and their descriptions.
Without Ideology, check the inherited launch gizmo label and tooltip; with Ideology it is
absent by design. Check for raw keys, English fallback in French, broken accents, paragraph
breaks and clipped text. Also load without Fireworks and check for translation load errors.
Record the languages, dependency version, observed screens and log results in STATUS.md.
These checks have not yet been performed in game.

## Pickle (Gherkin) suite: the scenarios above, played by the game, for a person to validate

Written on 2026-09-21 in `Tests/Pickle/`, so that scenarios 1 to 9 can be validated by looking at
captures and films instead of playing them. Each stages the situation with the game's real jobs and
comps, asserts what it can before each capture, and records the capture; the README there says what
a person looks at for each one. Read the tag before the colour: `@review` asserts nothing about an image.

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

**Passes the mod needs: three,** each playing the whole suite (26 scenarios, none `@wip`, none conditional on a
tag). It declares no optional mod and no incompatibility, so there is no "with optional mods" pass and none per
incompatibility. All on the minimal WSL set (Core, the DLC, Harmony, RimLogging, Pickle, Fireworks, the mod):

| Pass | Command |
| --- | --- |
| English, every DLC | `Run-PickleWsl.ps1 -Mod FireworkStand` |
| French | `Run-PickleWsl.ps1 -Mod FireworkStand -Language French` |
| Without Ideology | `Run-PickleWsl.ps1 -Mod FireworkStand -DepMap wsl-deps.sans-ideology.map` |

`Tests/Pickle/Run-Passes.ps1` plays the three in turn and keeps each report under `Tests/Pickle/runs/`. Two
scenarios read the game to know what to assert in a pass (`04-labels` reads the active language, `12-launch-gizmo`
whether Ideology is active), so each is green in every pass and none is skipped.

**Nothing is left manual.** The one case that cannot be played, Fireworks absent, is not a missing test: the mod
declares Fireworks in `modDependencies`, so no game exists in which the stand is loaded without it. The guard is
proved where it can be: the patch is a `PatchOperationConditional` on `FireworkLauncher` (`Test-Xml.ps1`,
`Check-DefInjected.ps1`) and the reflection bridge is read off the compiled assembly (`Run-Functional-Tests.ps1`).
The audience filter has no line-of-sight test on purpose, so there is nothing to test.

**Status.** The suite as it stands has never run. Before this shape, a 21-scenario version ran twice on
2026-09-21: French all green, English 18 passed and 1 failed with the report lost. A Pickle run only shows that the
path ran: it does not replace looking.

## Publishing gate

Scenarios 1 to 4 and 8 are the ones that gate publishing: they cover the patch, the bridge, the
rearming, the light and the save. 5, 6, 7 and 9 are behaviour worth getting right but a defect in
them is a patch note, not a blocker.
