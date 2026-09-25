# Firework Stand

If the original author contacts me to request its removal, I undertake to take it down promptly.

A RimWorld 1.6 mod. Turns [telardo's Fireworks](https://steamcommunity.com/sharedfiles/filedetails/?id=2922179297)
into a real recreation source, with a recreation type of its own.

In the original mod fireworks are either an Ideology ritual or a one-use item set off from a
gizmo — and with Ideology active that gizmo is not created at all, so the ritual is the only way.
This adds a building: colonists walk to it on their own, as recreation, and it fires while they
watch.

## What it adds, exactly

- **A new `JoyKindDef`.** That is the scarce commodity. Expectations ask for up to six different
  recreation types, tolerance is counted per type, and the base game offers eight, of which only
  four come from buildings.
- **Firing driven by the watching.** The stand never fires on a timer, so it wastes nothing at
  night, in the rain, or on an empty field. One rocket is spent per salvo, and only while somebody
  is there.
- **Two effects the original has no reason to provide**: the fuse smoking at the foot of the
  stand, and real light thrown across the ground for four seconds as each rocket leaves. The stand
  is dark the rest of the time — it is not a lamp.

Everything else — the bursts, the trails, the sub-emitters, the sounds, the mood memories — is
telardo's, called as it is. See [ATTRIBUTION.md](ATTRIBUTION.md).

## How it works

- `Mod/Patches/Stand.xml` adds the defs inside a `PatchOperationConditional` guarded on
  `FireworkLauncher` existing. Without Fireworks, nothing is patched and nothing errors.
- `FireworksBridge` resolves telardo's `CompLaunchFireworks` by reflection, so this assembly loads
  whether or not his mod is present. It rearms the comp before each salvo, which is what turns a
  single-use launcher into a reusable stand.
- `JobDriver_WatchFireworks` subclasses the base game's `JobDriver_WatchBuilding` and overrides
  `WatchTickAction`, which is `protected virtual`. **No Harmony patch anywhere in this mod.**
- `CompFireworkStand` implements `IThingGlower`, so `CompGlower` asks it before lighting: it
  answers yes only for the seconds after a launch.

## Layout

```
Mod/       published to the Workshop, and the junction target for RimWorld/Mods
Source/    never published
_tools/    the functional test suite, and the SVG sources for the About images
.build/    build intermediates, outside the mod folder and ignored by git
```

## Testing

Two halves, and only the second needs a colony.

```bash
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1
```

32 tests, fifteen seconds, no game launched. They read off the compiled game and off telardo's
assembly that the things this mod delegates to still do what it delegates them for: the virtual
slot the job driver grafts onto, the `IThingGlower` veto the light rests on, and the method and
field the bridge reaches for by name. A RimWorld installation and a subscription to Fireworks are
needed, since both are read from disk. The other half is [TESTING.md](TESTING.md), nine scenarios
for a running colony.

## Building

The reference assemblies come from NuGet (`Krafs.Rimworld.Ref`), so no RimWorld installation is
needed to compile:

```bash
dotnet build Source/FireworkStand.csproj -c Release
```

The DLL lands in `Mod/Assemblies/`. Intermediates go to `.build/`, kept out of the mod folder
because the Workshop uploader sends the mod directory as it is, with no exclusions.

## Licence

MIT, see [LICENSE](LICENSE).
