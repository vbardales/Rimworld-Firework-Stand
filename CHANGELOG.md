# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it in game.

## [Unreleased]

First version, not yet published. RimWorld 1.6.

### Added

- A firework stand: a building loaded with up to ten of telardo's firework launchers, watched as
  recreation. It fires one rocket per salvo, every quarter hour of game time, and only while a
  colonist is watching it.
- A recreation type of its own (`FS_Fireworks`), which is the point of the mod: expectations ask
  for up to six different types and the base game only offers eight.
- The fuse smoking at the foot of the stand while the rocket waits, and a real light thrown across
  the ground for four seconds as it leaves. The stand is dark the rest of the time.
- Watched from 4 to 12 cells away, standing, up to ten colonists at once, under open sky only.
- 40 steel and 20 wood, behind the IEDs research. English and French.

### Fixed

- The mood memory after a show went to every free colonist within twenty cells, asleep or indoors
  included. It now asks for the three things the defs already ask of the watcher: awake, under
  open sky, capable of sight. No ground line-of-sight test, since the burst is in the air and a
  wall does not hide it.

### Notes

- Nothing here has been observed running yet. `TESTING.md` lists the nine scenarios that would
  settle it, and says which five gate publishing.
- The defs sit inside a patch guarded on `FireworkLauncher`, and the link to telardo's comp is
  made by reflection: without Fireworks, nothing is patched and nothing errors.
- No Harmony patch. The watching job subclasses `JobDriver_WatchBuilding`, whose
  `WatchTickAction` is `protected virtual`.
- `About/Preview.png` is generated key art carrying the mod's name and one summary line, rendered
  at the 896x504 the Workshop pages use, in the treatment shared by every showcase in this
  collection. The full-size original is kept in `Art/`, outside the published folder. The vector
  placeholder it replaced still builds from `_tools/svg-about/`, as a fallback.
