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

### Notes

- The defs sit inside a patch guarded on `FireworkLauncher`, and the link to telardo's comp is
  made by reflection: without Fireworks, nothing is patched and nothing errors.
- No Harmony patch. The watching job subclasses `JobDriver_WatchBuilding`, whose
  `WatchTickAction` is `protected virtual`.
- The `About/Preview.png` shipped here is a placeholder rendered from `_tools/svg-about/`. It
  draws a braced rack, while the building reuses telardo's `FireworkLauncher` texture and appears
  in game as a single tube on the ground.
