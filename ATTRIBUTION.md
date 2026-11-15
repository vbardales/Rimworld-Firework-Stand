# Attributions

## Mod extended

**[Fireworks](https://steamcommunity.com/sharedfiles/filedetails/?id=2922179297)** by **telardo**
is the mod this one exists for. Firework Stand is useless without it, declares it as a dependency,
and calls into it at run time.

### Code studied, by decompilation

No file of telardo's is copied or redistributed. His assembly was decompiled to answer three
questions that the published mod does not document, and each answer is recorded next to the code
that relies on it:

- `CompLaunchFireworks.Launch(int delayTick)` reads only `parent.DrawPos` and `parent.Map`,
  registers the salvo with the mod's own MapComponent, and **does not destroy its holder**.
  Nothing in it assumes the holder is the original single-use item, which is what makes it legal
  to put the comp on a building.
- `CompLaunchFireworks.launched` is a public field the method sets to true so it fires once.
  Setting it back to false rearms the comp. This is the whole mechanism by which a one-shot
  launcher becomes a reusable stand.
- `CompLaunchFireworks`'s gizmo returns early under Ideology
  (`if (ModsConfig.IdeologyActive) yield break;`), which is why the manual button disappears for
  most players and why a recreation building is worth adding at all.
- `FireworkSpawner.TrySpawnFleck` already plays the `launchSound` carried by each FleckDef, and
  every sub-emitter plays its own `emitSound`. That is why this mod adds no sound of its own.

### Code reproduced

One thing is reproduced rather than called, because its method is private: the roll that hands out
the mood memories after a show — 5% terrible, 15% unimpressive, 70% beautiful, 10% unforgettable,
using telardo's own `ThoughtDef`s (`TerribleFireworks`, `UnimpressiveFireworks`,
`BeautifulFireworks`, `UnforgettableFireworks`), looked up by name and skipped silently if absent.
The odds and the defs are his; the radius is wider here, because the show comes from a fixed stand
the whole colony can see rather than from a rocket held in one hand.

### Assets

No texture, sound or def file is copied. The building draws itself with telardo's own
`Things/Item/FireworkLauncher` texture, loaded from his mod at run time — it ships in his folder,
not in this one.

Fireworks carries no licence file. Nothing of it is redistributed here; if telardo would rather
this mod did not exist in its current form, contacting me is enough.

## Base game

`JobDriver_WatchBuilding.WatchTickAction` is `protected virtual`, so the watching job is a plain
subclass and this mod needs no Harmony patch at all. `CompGlower.ShouldBeLitNow` polls every comp
implementing `IThingGlower`, which is the supported hook used here to keep the stand dark except
for the seconds after a launch.

## Tools

Code written with Claude Code (Anthropic), images generated with DALL-E (OpenAI), under human
direction, review and testing.

## Translations of the original

Two translations of Fireworks exist on the Workshop: German, **Fireworks - Deutsch**
([2963612025](https://steamcommunity.com/sharedfiles/filedetails/?id=2963612025)) by **Erdnussbrot**,
and Russian, **Fireworks ru**
([2944010494](https://steamcommunity.com/sharedfiles/filedetails/?id=2944010494)) by **Nevelian**.
Neither carries a licence file, so none of their text is copied here. They were read as a terminology
reference only (the German pack calls the launcher "Feuerwerkskiste", which this mod follows);
every German and Russian text in `Mod/Languages/German` and `Mod/Languages/Russian` was written for
this mod with Claude Code (Anthropic), from the English of Fireworks. Players who also subscribe to
those two packs keep them: the texts of the dependency (launcher, mood memories, the launch button)
are repeated here so the stand reads in one language even without them. The Russian pack's added
firework battery is not part of this mod.
