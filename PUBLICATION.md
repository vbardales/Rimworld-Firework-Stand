# Publication sheet

**Updated 2026-09-26. The mod is at `done`. The owner prepublished 0.1.0 by hand on 2026-09-23: the Workshop item exists
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
- **Publication goes through the CI, not the in-game button.** The workflow was generated on 2026-09-26 (`.github/`, 68 script tests pass, `About.xml` synchronised with the description below) and is not yet run: no dry-run exists. It is an update of an existing
  item, so the manual workflow of `Rimworld-Release-Admin/scripts/generate-publish-workflow.sh` applies, not the
  semantic-release one:

  ```bash
  Rimworld-Release-Admin/scripts/generate-publish-workflow.sh <this repository> \
    --workshop-id 3806767445 --package-id nelim.fireworkstand \
    --release-title "Firework Stand {version}" \
    --require Assemblies/FireworkStand.dll --require Defs --require Patches \
    --gallery-dir Gallery --description-markdown PUBLICATION.md --description-heading '^## Steam description$' \
    --about-from-description
  ```

  (the one Markdown source for the description, see "Steam description" below), then a dry-run on the exact commit (run id and SHA noted in `STATUS.md`), then
  `dispatch-publish.sh <owner/repo> publish-tag.yml <full SHA> 0.1.1`. Only the owner approves `steam-production`. The CI
  creates the tag `v0.1.1` and the GitHub release (the `## [0.1.1]` section of `CHANGELOG.md`, dated first) after a
  successful upload: not by hand. Options `update_preview`, `update_description`, `update_title` and `update_tags` are off
  by default; the Workshop description is that of 0.1.0, and it is replaced only if `update_description` is switched on for a
  publish (the dry-run prints the text and the diff against the page first).
- **Payload.** `Mod/` as committed, including the DLL built from `Source/` (the runner has no game assemblies to build
  with): `Assemblies/FireworkStand.dll`, `Defs/FuseSmoke.xml`, `Patches/Stand.xml`, `Languages/`, `About/`.

## Steam description

**One source, decided by the owner on 2026-09-25** (`PUBLISHING.md`; `Rimworld-Release-Admin/docs/OPERATIONS.md`, "Changing
where the Steam description comes from"): the description is written once, in Markdown, in the fenced block below. The CI
converts it to Steam BBCode and generates the plain-text `<description>` of `Mod/About/About.xml` from it, and every dry-run and
publish stops if `About.xml` differs from it. The block cannot contain a code fence, and its last line is the source link.
Adopted at this publication, not before: until the workflow is generated with the options above, `About.xml` stays as it is, and
the first `sync-about-description.mjs --write` rewrites its text (read the diff). The page still carries the 0.1.0 description,
sent when the owner created the item, and a publish replaces it only with `update_description` on.

Written from the current `About.xml`, with three changes to read: headings and links instead of plain capital lines, Pickle named
as a development tool in THANKS, and Fireworks linked to its Workshop page. The item is private, so the dry-run cannot diff
against the page: its printed text is read by hand.

```markdown
If the original author contacts me to request its removal, I undertake to take it down promptly.

Turns [telardo's Fireworks](https://steamcommunity.com/sharedfiles/filedetails/?id=2922179297) into a real recreation source, with a recreation type of its own.

In the original mod, fireworks are either an Ideology ritual or a one-use item you set off by hand, and with Ideology installed the manual button is not even created, so the ritual is the only way.

This adds a firework stand: a building loaded with firework launchers that colonists watch of their own accord, as recreation. The stand only fires while somebody is actually watching, so it never wastes a rocket on an empty field, and it must be built under open sky. A stand with nothing loaded gives no recreation.

The show itself (the bursts, the trails, the sounds, the mood memories) is telardo's, called as it is. What this adds is the recreation type, plus the two effects his mod has no reason to provide: the fuse smoking at the top of the rack, and real light thrown across the ground for a few seconds as each rocket leaves. The stand is dark the rest of the time; it is not a lamp. That is the scarce part: expectations ask for up to six different types, tolerance is counted per type, and the base game only offers eight, of which four come from buildings.

Fireworks is declared as a dependency, because the stand does nothing at all without it. The link itself is made at runtime by reflection, and the defs sit inside a guarded patch: if the mod is absent, nothing is patched and nothing errors. Ideology is not required either way. The stand appears in the Recreation category of the Architect menu once IEDs is researched. English and French.

No save data of its own beyond the stand's own reload timer.

## IF I GO QUIET

If I do not answer within a reasonable time after being contacted, anyone may freely update this or any other of my mods, including publishing a continuation of it. All credit must be preserved.

## AI-GENERATED

This mod's code was written with Claude Code (Anthropic) and its images generated with DALL-E (OpenAI), under human direction, review and testing. Stated openly: designing with these tools is my job.

## THANKS

- [telardo](https://steamcommunity.com/sharedfiles/filedetails/?id=2922179297), for Fireworks, whose show this mod calls rather than reimplements.
- Claude Code (Anthropic) and DALL-E (OpenAI).
- Pickle (RimWorks), used for the in-game tests: a development tool, never a dependency of the mod.

What this mod studied and what it reproduced is listed in ATTRIBUTION.md, and it is released under the MIT licence (LICENSE); both are in the repository linked below.

[Source code on GitHub](https://github.com/vbardales/Rimworld-Firework-Stand)
```

## Change notes (Steam), one block per version

The CI reads the block under `### <version>`. They are sent again at every update.

### 0.1.1

> [b]0.1.1[/b]
> Fixes. The fuse now smokes visibly at the top of the rack before each launch (the smoke was there but too faint to
> see). A stand with nothing loaded no longer counts as recreation: colonists stop going to it, and its inspect line no
> longer says "Ready to fire". The fuel line starts with a capital and the stand is drawn a little smaller, so its box stays
> in its cell. Saved data is unchanged: a colony saved with 0.1.0 loads as it was.

The CI refuses a note whose first line does not carry the version (`[b]0.1.1[/b]` or a heading): each block starts with it.
Confirm the first sentence against the last smoke pass before sending: it says what a person was shown, not what the
counts say.

### 0.1.0 (prepublished by hand on 2026-09-23, kept for the record)

> [b]0.1.0[/b]
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

**Zoom and crop (the owner's rule, 2026-09-26).** Every picture is taken with the camera all the way in, so that what it has
to prove fills as much of the window as the game allows (at least half its height wherever the subject allows it). The game
cannot zoom past its maximum, so `_tools/Crop-Gallery.ps1 -From Tests/Pickle/runs/<run> -To Gallery` then cuts a 16:9 window
around the subject, in native pixels, leaving out the studio's alerts, the "Area revealed" letters and the colonist bar. The
crops are read off the pictures: re-read them after any change of camera in `14-gallery.feature`. Each picture is opened,
after the crop, to check that it shows what it is meant to prove: the stand, its light, the burst.

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
whether a comment is still needed: **telardo's Fireworks (`2922179297`) had no row; it has one since 2026-09-26 (`drafted`)**, so this is the first contact and
the draft below is the one registered (Pickle, `3791648678`, is already `posted` and covers this mod's tests once
its `Covers` names Firework Stand). One recipient, under 1000 characters, BBCode allowed; a bare item URL on its own line
makes a thumbnail.

**telardo, on Fireworks** (`https://steamcommunity.com/sharedfiles/filedetails/?id=2922179297`), comment page. Status:
`drafted` (register row added 2026-09-26). Written to the register's method of 2026-09-26: her plain voice, one concrete
true thing, one link hidden behind BBCode, under 350 characters. **She reads and rewords it before it goes up**; it is
posted by her, once the item is public and after reading the last comments of the page.

> Thank you for Fireworks! I made a small stand around it: colonists walk over and watch your launchers as recreation,
> and your show (bursts, trails, sounds) is called as it is, nothing copied. I read your assembly to see how it fires, it's
> credited. Tell me if you'd rather I did something differently :)
> [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3806767445]Firework Stand[/url]

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
