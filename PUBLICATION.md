# Publication sheet

**Updated 2026-09-25. The mod is at `done`. The owner prepublished 0.1.0 by hand on 2026-09-23: the Workshop item exists
(`3806767445`, private) and `Mod/About/PublishedFileId.txt` is committed. Ahead: `tested`, the 0.1.1 update through the CI,
the switch to public (by the owner) and the thank-you to telardo.** This sheet holds what the Workshop page asks for and
the repository holds nowhere else, so that it can be used again at the next update and by whoever picks the mod up.

Rules that apply, and where they are written: `PUBLISHING.md` and `AUDIT.md` (protocols repository, read versions in
`docs/PROTOCOLS-READ.md`), `Rimworld-Release-Admin/docs/OPERATIONS.md` for the CI.

## Before publishing

- **Stage.** `tested` first: the three Pickle passes green on the final build, the captures and films looked at by a person,
  the logs read (`STATUS.md`, `remaining`). The owner's fail-fast policy (2026-09-25) lets the publication go once no red is
  open and the regression pass runs afterwards, but never skips: every red scenario replayed green on a build with its fix
  (the fuse smoke is one), the Workshop gallery, the owner's manual validations, the dry-run of the exact commit and the
  approval of `steam-production` by the owner, and a rollback target chosen beforehand (a tag at every good version).
- **Publication goes through the CI, not the in-game button.** The mod has no workflow yet. It is an update of an existing
  item, so the manual workflow of `Rimworld-Release-Admin/scripts/generate-publish-workflow.sh` applies, not the
  semantic-release one:

  ```bash
  Rimworld-Release-Admin/scripts/generate-publish-workflow.sh <this repository> \
    --workshop-id 3806767445 --package-id nelim.fireworkstand \
    --release-title "Firework Stand {version}" \
    --require Assemblies/FireworkStand.dll --require Defs --require Patches \
    --gallery-dir Gallery ...
  ```

  (`--description-file` with a heading, or `--description-markdown`, is chosen when it is generated, from where the
  description text ends up living: the generator takes the fenced block under a heading of a file. Nothing here is a fenced
  description yet, and the description is not updated by default, so no choice is made in this sheet.)

  then a dry-run on the exact commit (run id and SHA noted in `STATUS.md`), then
  `dispatch-publish.sh <owner/repo> publish-tag.yml <full SHA> 0.1.1`. Only the owner approves `steam-production`. The CI
  creates the tag `v0.1.1` and the GitHub release (the `## [0.1.1]` section of `CHANGELOG.md`, dated first) after a
  successful upload: not by hand. Options `update_preview`, `update_description`, `update_title` and `update_tags` are off
  by default; the Workshop description is that of 0.1.0, and it is replaced only if `update_description` is switched on for a
  publish (the dry-run prints the text and the diff against the page first).
- **Payload.** `Mod/` as committed, including the DLL built from `Source/` (the runner has no game assemblies to build
  with): `Assemblies/FireworkStand.dll`, `Defs/FuseSmoke.xml`, `Patches/Stand.xml`, `Languages/`, `About/`.

## Description

Sent to Steam only when the item is created, or by a publish with `update_description`. `Mod/About/About.xml` is the
source for the first, and this block for the second if it is used. It ends, in this order, with the removal commitment at
the top, `IF I GO QUIET` (adoption clause verbatim), `AI-GENERATED`, `THANKS`, the line pointing to `ATTRIBUTION.md` and the
licence, and `[url=https://github.com/vbardales/Rimworld-Firework-Stand]Source code on GitHub[/url]`. Read it one last time
before sending: `Test-Xml.ps1` checks that it ends with the link, not that it reads well.

THANKS names what really helped, people and tools, each as the owner's rules ask: **telardo** for Fireworks (linked to its
Workshop page), **Claude Code (Anthropic)** and **DALL-E (OpenAI)**, and, as development tools that are never a dependency,
**Pickle** (RimWorks) for the in-game tests. `About.xml` does not name Pickle yet (to add after the queued runs).

## Change notes (Steam), one block per version

The CI reads the block under `### <version>`. They are sent again at every update.

### 0.1.1

> Fixes. The fuse now smokes visibly at the foot of the stand before each launch (the smoke was there but too faint to
> see). A stand with nothing loaded no longer counts as recreation: colonists stop going to it, and its inspect line no
> longer says "Ready to fire". Saved data is unchanged: a colony saved with 0.1.0 loads as it was.

Confirm the first sentence against the last smoke pass before sending: it says what a person was shown, not what the
counts say.

### 0.1.0 (prepublished by hand on 2026-09-23, kept for the record)

> First release. Adds a firework stand: a building loaded with up to ten Fireworks launchers that colonists walk over to and
> watch as recreation, standing, from 4 to 12 cells away. It fires one rocket per salvo, only while somebody watches, and it
> adds its own recreation type. The fuse smokes before the launch and the ground is lit for about four seconds as the rocket
> leaves. Requires Fireworks. English and French.

## Dependencies and DLC

- **Fireworks (telardo, `2922179297`, `telardo.Fireworks`): a hard dependency, and it is declared** in `modDependencies`
  with its Steam URL, and in `loadAfter`. The code reaches its `CompLaunchFireworks` by reflection, the patch is guarded on
  its `FireworkLauncher`, and the stand does nothing without it: not a recommendation.
- **Ideology: not required.** With Ideology active, Fireworks hides its own launch gizmo, which is why a stand is worth
  having; the mod works with or without it. No `LoadFolders.xml`, no `IfModActive` branch in this mod. Fireworks selects its
  own Ideology data itself.
- **Supported versions: 1.6 only.** No other optional mod, no declared incompatibility.
- **Not checked from here:** whether the Workshop page of Fireworks lists a 1.6 build; the mod's own dependency declaration
  was verified from the installed About.xml only.

## Gallery (manual: no tool of the chain can send it)

The Workshop gallery is added by hand on the Steam page, in the order below. The folder `Gallery/` (at the repository root,
not in `Mod/`) holds **only the images to upload, numbered `01-`, `02-`, ... in the order they go on the page, and nothing
else** (no older version, no raw capture, no subfolder): it is also the workflow's `--gallery-dir`. Raw captures stay in
`Tests/Pickle/runs/`, ignored by git, and are deleted once cropped. The folder does not exist yet.

The images come from a **scenario of their own** that mounts the scene (`ScreenshotStudio`, the fixture
`nelim-zen-meadow-studio`, staged with ClearScreen), not from the test colony's captures: those show a skeleton beside the
stand, dev tools may show, and a still taken during a film carries the film's corner frame. Each image is opened before it
is kept: a green capture scenario shows that the trajectory ran, not that the picture shows anything.

Steam shows the first one large: the most demonstrative, not the prettiest. Order to confirm on the images themselves:

1. **The audience**: the stand, a colonist beside it, a burst overhead. The one that says what the mod is.
2. **The fuse and the launch**: smoke rising from the rack, then the puff and the sparks (the still taken mid-fuse).
3. **The ground lit at night as the rocket leaves**: the flash, warm, on dark ground.
4. **The stand counting down its reload**: the gauge and the inspect line.
5. **The blueprint**: buildable through the normal Architect menu (Recreation, after IEDs).

## Content boxes (adult content, violence)

Nothing in the mod, the Preview, the ModIcon or the captures viewed so far shows nudity, gore or sexual content; the only
body was the test colony's skeleton, which the showcase scenario removes. Answer **no adult content**, after opening the
final gallery images: the boxes commit the page.

## Thanks to post, after the item is public

A link to a private item opens for nobody, so post only once it is public. The register `WORKSHOP_COMMENTS.md` decides
whether a comment is still needed: **telardo's Fireworks (`2922179297`) has no row yet**, so this is the first contact and
the draft below is to be registered as `drafted` (Pickle, `3791648678`, is already `posted` and covers this mod's tests once
its `Covers` names Firework Stand). One recipient, under 1000 characters, BBCode allowed; a bare item URL on its own line
makes a thumbnail.

**telardo, on Fireworks** (`https://steamcommunity.com/sharedfiles/filedetails/?id=2922179297`), comment page. Status:
`drafted`.

> Thank you for Fireworks. I made a small mod around it, Firework Stand: a building loaded with your launchers that
> colonists walk over to and watch as recreation, with a recreation type of its own. Your show is called as it is,
> the bursts, the trails, the sounds and the memories, and nothing of yours is copied or shipped. I read your
> assembly to see how the comp fires, and it is credited in the attribution file. If you would rather I did
> something differently, tell me and I will. https://steamcommunity.com/sharedfiles/filedetails/?id=3806767445

`STATUS.md` records `upstream_permission: silent`: no licence or permission found for Fireworks, the takedown commitment
stands, and this message is also the first contact. Update the register the moment it is posted.

## After the publication: what the owner follows

By hand, on her accounts, never by a session (`PUBLISHING.md`, "Mise en production d'une 1.0.0"): subscribe to the comments
of the Workshop item (`3806767445`); "Watch all activity" of the item and of its parent mod Fireworks (`2922179297`); and,
on GitHub, **Watch, All activity** on `https://github.com/vbardales/Rimworld-Firework-Stand` for the commits and issues of
this repository.

## Right after an upload, and it cannot be undone

- **`Mod/About/PublishedFileId.txt` is committed** (done 2026-09-23, item 3806767445). Lost, the next upload would create a
  second item.
- **Steam creates every item private**; RimWorld never calls `SetItemVisibility`, and the CI never sends it. Subscribe to
  your own item, test it, then switch it to public by hand. When a 1.0.0 goes to production, the owner also subscribes to
  the comments and watches all activity of the item and of Fireworks, by hand (`PUBLISHING.md`).
- After a publish, read the public page (description, change notes, images): a green release does not prove Steam is up to
  date. Record the evidence in `STATUS.md`.
