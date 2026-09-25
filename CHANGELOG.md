## [0.1.1] - unreleased

Three defects found on the first full in-game run of the Pickle suite, and confirmed by the owner. The stand's saved
data is unchanged, so a colony saved with 0.1.0 loads as it was.

### Fixed

- **The fuse smoke could not be seen.** The stand's effects (the fuse smoke, the launch puff and sparks, the light going
  out) were timed in `CompTickInterval`, which the game runs only every few ticks for a building with a Normal ticker,
  so a sixty-tick fuse smoking every twelve ticks fell between two calls. They are now timed in `CompTick`, which runs on
  every tick and the light goes out on time. That was not enough to see it: the game's own Smoke fleck fades in over half
  a second and the fuse lasts one, so the thread was still invisible when the rocket left. The fuse now throws its own smoke
  (`FS_FuseSmoke`, in `Mod/Defs/FuseSmoke.xml`), which is there almost at once. Functional tests read the game and the def
  to keep both from coming back.
- **An empty stand no longer gives recreation.** The base game's watch-building giver never looks at fuel, so colonists
  went to an empty stand and were paid the whole recreation without a rocket going up. The stand now has its own joy
  giver that refuses an empty stand, and the watching job ends once the last rocket has gone and its burst has faded.
- **An empty stand no longer reads "ready to fire".** The inspect line reported the reload interval and not the fuel; it
  now says nothing when nothing is loaded, and the fuel gauge beside it says so.

## [0.1.0] - 2026-09-23

First version. RimWorld 1.6. Creation of the `PublishedFileId.txt` file (`Mod/About/PublishedFileId.txt`): the
Workshop item, 3806767445, was created by the first upload and is private until it is switched to public by hand.

### Added

- A firework stand: a building loaded with up to ten of telardo's firework launchers, watched as
  recreation. It fires one rocket per salvo, every 900 ticks (about twenty-two in-game minutes), and only while a
  colonist is watching it.
- A recreation type of its own (`FS_Fireworks`), which is the point of the mod: expectations ask
  for up to six different types and the base game only offers eight.
- The fuse smoking at the foot of the stand while the rocket waits, and a real light thrown across
  the ground for four seconds as it leaves. The stand is dark the rest of the time.
- Watched from 4 to 12 cells away, standing, up to ten colonists at once, under open sky only.
- 40 steel and 20 wood, behind the IEDs research. English and French.

### Fixed

- Completed French translations for the stand, recreation type, job and fuel messages,
  plus the reused Fireworks launcher, launch command and four mood memories.
- The mood memory after a show went to every free colonist within twenty cells, asleep or indoors
  included. It now asks for the three things the defs already ask of the watcher: awake, under
  open sky, capable of sight. No ground line-of-sight test, since the burst is in the air and a
  wall does not hide it.
- The stand was setting `showFuelGizmo` on its refuelable comp. The field still exists in 1.6 and
  nothing in the game reads it any more, so the line was a comment. Removed, with a note where it
  was. The fuel gauge shows either way. Found by the functional suite on its first run.

### Notes

- The scenarios of `TESTING.md` are played by Pickle in a real game (`Tests/Pickle/`), which records captures and
  films for a person to validate. `TESTING.md` and `STATUS.md` say what has run and what has not.
- `_tools/Run-Functional-Tests.ps1` settles what a colony is not needed for: 31 tests, fifteen
  seconds, no game launched. It reads off the compiled game that the hooks this mod grafts onto
  still do what it grafts onto them for, and off telardo's assembly that the three things reached
  by reflection are still there under those names. Twenty of the tests have been seen to fail on
  purpose; the five that could not be are named in the file.
- The defs sit inside a patch guarded on `FireworkLauncher`, and the link to telardo's comp is
  made by reflection: without Fireworks, nothing is patched and nothing errors.
- No Harmony patch. The watching job subclasses `JobDriver_WatchBuilding`, whose
  `WatchTickAction` is `protected virtual`.
- `About/Preview.png` is generated key art carrying the mod's name and one summary line, rendered
  at the 896x504 the Workshop pages use, in the treatment shared by every showcase in this
  collection. The full-size original is kept in `Art/`, outside the published folder. The vector
  placeholder it replaced still builds from `_tools/svg-about/`, as a fallback.
