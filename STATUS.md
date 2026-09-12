---
mod:        Firework Stand
packageId:  nelim.fireworkstand
repo:       Rimworld-Firework-Stand
visibility: public
detached:   yes
stage:      done
licence:    alive
licence_at: Fireworks ships no licence file, and telardo is alive; nothing of his is redistributed here
showcase:   complete
tested_on:
workshop:
remaining:
  - unverified: never seen running in game; TESTING.md sets out nine scenarios, five of which gate publishing
  - unverified: five of the 25 out-of-game tests are claims about Assembly-CSharp itself and could not be seen to fail; they are the driver hook and the light veto, the two that matter most
  - defect: the inspect line reads "Ready to fire" on an empty rack, because it reports the interval and not the fuel; the gauge beside it says the truth
  - defect: the mod icon is the orange face, which does not depict the building and reads poorly at 32 px; deviation accepted on 2026-09-04, not to be reopened
session:    local_db219fa5-6fea-40f2-b0fa-aa63c79d3774
updated:    2026-09-12, the mod's own session
---

# Firework Stand — status

Read by a sweep across every mod, rather than by asking each thread in turn. It lives at the root,
never inside `Mod/`, so Steam never receives it.

The fields above were deduced from disk on 2026-09-12 by that sweep, then taken in hand the same
day by the session that holds this mod. One of its deductions was wrong, and one of the
corrections made on top of it was wrong in turn and has been undone.

- **`stage`** — `done` confirmed, and the changelog reading `[Unreleased]` does not argue against
  it. A mod never played can be `done`: the trial is what `tested_on` and `remaining` are for, and
  being on the Workshop is its own value, `published`. What `done` says is that the content, the
  images, the documentation and the out-of-game suite are finished, which they are.
- **`licence`** — `alive`, not `silent`. The sweep was right about the fact, Fireworks ships no
  licence file, and wrong about what it implies: `silent` is for a source that is also dead, and
  telardo still maintains his, updated for 1.6. The difference is not cosmetic, because a living
  author can be asked.
- **`tested_on`** — empty, and correct. Nobody has ever seen this mod run. The packageId appears
  in no `ModsConfig.xml`.
- **`workshop`** — empty, and correct. There is no `PublishedFileId.txt` in `Mod/`, so nothing has
  ever been uploaded. The showcase is ready regardless.
- **`remaining`** — the line posted by default gives way to four: two unknowns and two known
  defects.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source, `alive` no
licence but a living source, `forbidden` a written refusal, `original` nothing reused.

## What `alive` means here

This mod does not extend a dead source. It extends a living one, declares it as a dependency and
calls into it at run time. Nothing of telardo's is copied: no texture, no sound, no def file. The
building draws itself with his own `Things/Item/FireworkLauncher` texture, loaded from his folder.
One thing is reproduced rather than called, because its method is private, the roll that hands out
the mood memories, and `ATTRIBUTION.md` says so line by line.

What that means in practice: if telardo would rather this mod did not exist in its current form,
saying so is enough. That is written into `ATTRIBUTION.md`.

## What is left, plainly

The in-game trial, and nothing else on the development side. `TESTING.md` cuts it into nine
scenarios and says which ones gate publishing. The two that count are **3**, the rearming, which is
the single mechanism the whole mod rests on, and **4**, the glower veto, whose failure leaves a
loaded stand lit permanently like a lamp.

The other half of the testing needs no colony and runs in fifteen seconds:

```
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1
```

It has already found one real defect, `showFuelGizmo`, which has no reader left in 1.6. But five of
its 25 tests are claims about `Assembly-CSharp` itself and could not be seen to fail, since proving
them would mean rewriting the game's IL. They are precisely the driver hook and the light veto,
which is why the second `remaining` line exists and why only a colony will clear it.

One thing to know before playing it: the building is **absent from the Architect menu** until
`IEDs` is researched, not greyed out. A fresh colony therefore looks like a broken mod.

## How this sheet is kept up to date

After any change to the mod, reread the fields, and three of them above all:

- `stage` is about fabrication, not about play or release: `tested` and `published` are the values
  for those, and neither is reached yet.
- `tested_on` takes the date of a trial that went well, with whatever was only partly covered said
  in `remaining`.
- `remaining` loses a line as soon as it stops being true, and gains one only for something you
  could name to somebody else.

The rest is deduced from disk and the sweep will redo it. `session` is the sweep's own bookkeeping:
this sheet does not touch it.
