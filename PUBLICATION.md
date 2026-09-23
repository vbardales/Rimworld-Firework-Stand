# Publication sheet

**Updated 2026-09-23. The mod is at `done`. The owner prepublished 0.1.0 by hand on 2026-09-23: the Workshop item exists
(`3806767445`, private) and `Mod/About/PublishedFileId.txt` is committed. What is still ahead: `tested`, the tag and
release, the switch to public and the message to telardo.** This sheet holds what the Workshop page asks for and the
repository holds nowhere else, so that it can be used again at the next update and by whoever picks the mod up.

## Before the first upload

- **Stage.** `tested` must be reached first: the English and French Pickle passes green, the captures and films
  looked at by a person, the logs read (`STATUS.md`, `remaining`). Then tag `v1.0.0` and publish the GitHub release
  with the `CHANGELOG.md` text; the Workshop item must not be newer than its repository.
- **Description.** It is sent to Steam only when the item is created (`SetItemDescription`), so what is in
  `Mod/About/About.xml` is what the page will say until someone edits it by hand on Steam. It ends, in this order, with
  the removal commitment at the top, `IF I GO QUIET` (adoption clause verbatim), `AI-GENERATED`, `THANKS`, the line
  pointing to `ATTRIBUTION.md` and the licence, and `[url=https://github.com/vbardales/Rimworld-Firework-Stand]Source
  code on GitHub[/url]`. Read it one last time before clicking: `Test-Xml.ps1` checks that it ends with the link, not
  that it reads well.
- **Release notes** (paste into the change note field at upload; they are sent again at every update):

  > First release. Adds a firework stand: a building loaded with up to ten Fireworks launchers that colonists
  > walk over to and watch as recreation, standing, from 4 to 12 cells away. It fires one rocket per salvo, only
  > while somebody watches, and it adds its own recreation type. The fuse smokes before the launch and the ground
  > is lit for about four seconds as the rocket leaves. Requires Fireworks. English and French.

## Dependencies and DLC

- **Fireworks (telardo, `2922179297`, `telardo.Fireworks`): a hard dependency, and it is declared** in
  `modDependencies` with its Steam URL, and in `loadAfter`. The code reaches its `CompLaunchFireworks` by reflection,
  the patch is guarded on its `FireworkLauncher`, and the stand does nothing without it: not a recommendation.
- **Ideology: not required.** With Ideology active, Fireworks hides its own launch gizmo, which is why a stand is
  worth having; the mod works with or without it. No `LoadFolders.xml`, no `IfModActive` branch in this mod. Fireworks
  selects its own Ideology data itself.
- **Supported versions: 1.6 only.** No other optional mod, no declared incompatibility.
- **Not checked from here:** whether the Workshop page of Fireworks lists a 1.6 build; the mod's own dependency
  declaration was verified from the installed About.xml only.

## Captures for the Workshop page

Steam shows the first one large: put the most demonstrative there, not the prettiest. **Take them from the English
pass** (the Workshop text is English); the French pass captures (on disk in `Tests/Pickle/runs/2026-09-21-french-full/`, ignored by git) show
what to expect. Proposed order, to be confirmed once the English pass has produced its own:

1. **The audience** (`10-audience`): the stand, a colonist beside it, the roofed patch with the two who did not see
   it, and a burst overhead. The one that says what the mod is.
2. **The puff and the sparks as the rocket leaves** (`06-fuse-and-launch`, twin scenario, unfilmed).
3. **The ground lit at night as the rocket leaves** (`05-light`, twin scenario). Only from the unfilmed twin: a still
   taken during a film carries the film's corner frame.
4. **The stand counting down its reload** (`11-inspect-pane`): shows the gauge and the inspect line.
5. **The blueprint** (`11-inspect-pane`): shows it is buildable through the normal designator.

Each image must be opened before it is uploaded: a green capture scenario shows that the trajectory ran, not that the
picture shows anything. Things to look for, seen on the French run: **a skeleton (a corpse of the test colony) sits
beside the stand in almost every capture**; crop it or move the stand, or a page about fireworks shows a body. The
game's own interface is visible; the runner panel is not.

## Content boxes (adult content, violence)

Nothing in the mod, the Preview, the ModIcon or the captures viewed on 2026-09-21 (sixteen French-pass stills, the
Preview and the ModIcon, all opened) shows nudity, gore or sexual content; the only body is the skeleton above.
Answer **no adult content**. Re-open the English-pass images before answering: the boxes commit the page.

## Thanks to post, after the item is public

A link to a private item opens for nobody, so post only once it is public. One recipient, under 1000 characters, BBCode
allowed; a bare item URL on its own line makes a thumbnail.

**telardo, on Fireworks** (`https://steamcommunity.com/sharedfiles/filedetails/?id=2922179297`), comment page:

> Thank you for Fireworks. I made a small mod around it, Firework Stand: a building loaded with your launchers that
> colonists walk over to and watch as recreation, with a recreation type of its own. Your show is called as it is,
> the bursts, the trails, the sounds and the memories, and nothing of yours is copied or shipped. I read your
> assembly to see how the comp fires, and it is credited in the attribution file. If you would rather I did
> something differently, tell me and I will. https://steamcommunity.com/sharedfiles/filedetails/?id=<the new item>

Replace `<the new item>` with the Workshop id once it exists. `STATUS.md` records `upstream_permission: silent`: no
licence or permission found for Fireworks, the takedown commitment stands, and this message is also the first contact.

## Right after the upload, and it cannot be undone

- **`Mod/About/PublishedFileId.txt` is committed** (done 2026-09-23, item 3806767445). Lost, the next upload would create a second item.
- **Steam creates every item private**; RimWorld never calls `SetItemVisibility`. Subscribe to your own item, test it,
  then switch it to public by hand.
- Record the Workshop id in `STATUS.md`, then post the message above.
