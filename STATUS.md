---
localization: complete
translation_en: complete
translation_fr: complete
mod:          Firework Stand
packageId:    nelim.fireworkstand
repo:         Rimworld-Firework-Stand
remote:       https://github.com/vbardales/Rimworld-Firework-Stand.git
local_path:   C:\Users\nelim\Documents\rimworld\FireworkStand
visibility:   public
detached:     yes
workflow_stage: playTests[1.0.0]
licence:      open
licence_at:   MIT in LICENSE and Mod/LICENSE for this mod; upstream permission is separate and not established
upstream_mod_remotes: N/A
upstream_permission: silent
upstream_permission_at: No licence file found in the installed Fireworks dependency; no explicit consent or written refusal documented
maintainer:   Codex, responsible for this repository and STATUS.md
dependencies: declared
showcase:     complete
tested_on:    partial, 2026-09-23 and 24, in game through Pickle in the WSL: the reshaped suite passed 26 of 26 in English and in French on the 0.1.0 build; on the 0.1.1 build the English pass ran 26 of 27 (exitReason failed, the one failure a bug of the smoke step, fixed), the French pass on the same build ran 26 of 27 the same way, and the without-Ideology pass (feature 12 only) passed 1 of 1. The smoke scenarios showed the puffs thrown but not visible (the game's Smoke fades in over half a second, the fuse lasts one), so the fuse now has its own fleck (FS_FuseSmoke, d51b7dd) and the smoke pass is rerun on it; the empty-stand fix is seen on the captures of both languages. A fourth pass, vitrine (feature 14, the Workshop gallery in the ScreenshotStudio meadow), has been played three times (2026-09-25 and 26, docs/runs/2026-09-26-vitrine-4.md): 3 scenarios of 4 green, the night one red (the stand fires, its light is not seen), replayed with a tracing step; every picture is now taken at maximum zoom and cropped. The owner has validated captures 1 to 6; the fuse smoke (capture 7) is open. Final whole-suite passes on the last build are still to run. Stage stays done.
automated_on: 2026-09-21
workshop:     3806767445, created by the owner's first upload of 0.1.0 on 2026-09-23, private. The item went up ahead of the chain (stage is done, not tested), the owner's choice and not an oversight. Mod/About/PublishedFileId.txt holds the id and is committed. The description as sent carries the ATTRIBUTION and licence line.
settings_audit: not_applicable
audit_on:     2026-10-11
echo_review_sha: 8530399bd25bc1d82e008e42813bc69636749799
social_preview_sha256: 8955bcdc4436739f7df1f0fe3e59e76c7626fe6c0d8d251e30ff29b0dae7560f
audit_revision: 60cf3715461f1d099dfdddb2d393961beb185ec6
remaining:
  - audit 2026-10-11 (done -> playTests[1.0.0], vocabulary only, nothing lowered): old journal moved to docs/runs/STATUS-journal-to-2026-10-11.md, old `remaining` kept at its end.
  - unverified (8.c): the staged gallery (feature 14, scenarios 01 to 04b, Pickle Tools steps StageDecor and ColonistRace and the head-type and beard steps) has never been replayed since the staging of 2026-10-02: small ticket, feature 14 only, then every picture opened. The wrong Def names (WoodPlankFloor, StandingLamp, Stool, Plant_Rose, Bob, Apparel_CollarShirt, Apparel_Pants) are named by the first run.
  - unverified (8.d, 8.k): the owner's look at the `@review` captures and films of the final build (docs/OWNER-CHECKS.md); fuse smoke (capture 7) validated as a principle, the gallery image has to show it larger.
  - unverified (non-regression, after commit and deployment, AUDIT.md section 15): the three whole-suite passes on the final build (English, French, without Ideology), filed together.
  - code review 8.m done 2026-10-13 on `cdca0a9..${H:0:7}` (no tag, from the first commit), Source/ and Mod/: no blocking defect; two cosmetic notes below, not fixed (a Source edit would reopen the review and the staged ticket)
  - local scripts: Crop-Gallery.ps1 and Run-Functional-Tests.ps1 justified in scripts/LOCAL_SCRIPTS.md, waiting for the Audit workflow session to validate; Collect-Evidence, Run-Passes, build-about.sh and svg-about deleted 2026-10-11
  - limitation: five existing assembly contract tests have no recorded mutation test; passing outside the game does not establish runtime behaviour
  - accepted: current Preview including its camera approved 2026-09-13; orange-face mod icon deviation accepted 2026-09-04; light is a flash at the rocket's departure, not a lamp (2026-09-24)
session:      local_6c5dcb78-92e8-4c24-ba24-a93528b66105
updated:      2026-10-11
code_review_sha: 341107f159930c986a2e99bf573914605851767d
protocols_read_sha: abe91647aaaabbb913f42a9a699ab0b3db63942c
---

# Firework Stand: status

Current state only. History up to the audit of 2026-10-02 (ownership, licence, title, tests, translation audit, Pickle runs, owner validations, French review, gallery staging) is in `docs/runs/STATUS-journal-to-2026-10-11.md`.

## Audit 2026-10-11 (`done` -> `playTests[1.0.0]`)

Old vocabulary mapped by AUDIT.md section 16. The criteria of `done` held on 2026-10-02 and nothing since lowers them: the French review is recorded (`translation_fr: complete`), the Pickle suite is written (14 features), the gallery was staged as photographs and its subject given a face (615556c), `Art/` was reorganised (296f187). What `playTests` still needs is the `remaining` list above.

**Replayed today against the current protocols (section 16).** `Tests/Run-Functional-Tests.ps1`: 33 tests passing. `scripts/Check-ModBasics.ps1`: PASS (11 XML files, 1 def, About.xml, notices, images). `Check-XmlFields`, `Check-TypeRefs`: clean. `dotnet build Source/FireworkStand.csproj -c Release`: 0 errors, 0 warnings, `Mod/` unchanged. Dependencies, settings (`not_applicable`) and plurals: unchanged since 2026-10-02, sources not touched. Pickle suite written (14 features), no `@wip`, nothing manual. Nothing run in game.

**Closing pass 3 (mod root), done 2026-10-11.** `.build/` is now `build/` (both `Directory.Build.props`, `.gitignore`, README; the old folder was build intermediates only, deleted, rebuilt in `build/`). `_tools/` is gone: `Run-Functional-Tests.ps1` and `Collect-Evidence.ps1` to `Tests/`; `Crop-Gallery.ps1`, `build-about.sh`, `svg-about/` to `scripts/`; `Test-Xml.ps1` deleted (every check in it is generic, the shared `Check-ModBasics.ps1` and `Check-Translations.ps1` cover them); `Generate-FrenchReview.ps1` deleted, `FRENCH_REVIEW.md` is now written by the shared `scripts/Make-FrenchReview.ps1`, fed by `french-review-english.json` for the 20 rows whose English lives in `Mod/Patches/Stand.xml` or in the dependency (French texts unchanged, review of 2026-10-02 stands). Root now holds only `.git`, `.github`, `.gitignore`, `.gitattributes` and the visible folders. `LOCAL_SCRIPTS.md` rows for these scripts: left to the Audit workflow session.

**CI copy.** `.github` regenerated with `generate-publish-workflow.sh --regenerate` (template `a549eb5c3aa4`): `Check-CiTemplate.ps1` 0 drift.

**ModIcon accepted by the owner, 2026-10-11.** `Art/ModIcon-source.png` is hers and untouched. Regenerated: `Mod/About/ModIcon.png` (128x128, 34 KB, by `Render-Preview.cjs` with `modIconSource` now set in `Art/Preview.config.json`), `Art/ModIcon.ico` (16, 32, 48, 256), `Mod/About/Preview.png` (678 KB, under 1 MB), `Art/Gallery/0-preview.png` (byte-identical to the Preview), `Art/Preview.ico`. Opened: the badge sits bottom-left, readable, nothing cropped. **Open:** upload the new `Mod/About/Preview.png` as the GitHub social preview (PUBLISHING.md, "Image de partage"), after the push; the echo review (10.a) is at `mountPreview`, not here.

**Translation audit (current).** `localization`, `translation_en`, `translation_fr`: `complete`; French reviewed by Virginie 2026-10-02 on revision `7a59b01`, French files untouched since (only `FRENCH_REVIEW.md` regenerated by the shared script). Reused dependency keys: `LaunchFirework`, `LaunchFireworkDesc` (telardo.Fireworks, English in the dependency, French in `Mod/Languages/French/Keyed/Fireworks.xml`). `scripts/Check-Translations.ps1 -DependencyKeyed LaunchFirework,LaunchFireworkDesc`: PASS (3 source texts + 1 nested, 2 Keyed calls). Pass the two keys as a list inside `powershell -Command`; with `-File` the comma list arrives as one string. In game, English and French captured and read on 2026-09-23 and 24 (see the journal).

**Settings audit (current).** `not_applicable`: no setting, no settings page, no MainButtons entry (sources read 2026-10-02, unchanged).

**Vitrine pass of 2026-10-11 (ticket 20261011-213108-536-96e1, build eda7447): red, 0 of 4, a defect of the suite.** Every scenario of `14-gallery` failed on load: `Fixture 'nelim-zen-meadow-studio' not found` (the studio was deleted on 2026-10-08, galleries play in the Sanctuary). Evidence `Tests/Pickle/runs/2026-10-11-vitrine-staged` (the RUN_DONE message never reached the session; read from disk 2026-10-12). Fixed 2026-10-12: feature 14 rewritten for the Sanctuary (save `Nelims-tribe`, place `bare-clearing`: bare earth, open sky, no roof; the set shifted by (+44, +54) from the old cells, stand at (198, 152)); `wsl-deps.vitrine.map` is now the Backlot's minimum list plus `nelim.sanctuarybacklot`. Never run in this shape: the cells, the Def names (WoodPlankFloor, StandingLamp, Stool, Plant_Rose, Bob, Apparel_CollarShirt, Apparel_Pants) and Miel's creation (`a colonist "Miel" of kind "Colonist" exists`) are guesses until a run.

**Vitrine pass of 2026-10-12 (ticket 20261012-042137-213-809c, build 992b6fd): green 4 of 4, `exitReason: passed`; the session's verdict on the nine pictures: refused as gallery images** (evidence `Tests/Pickle/runs/2026-10-12-vitrine-sanctuary`, opened by the session 2026-10-12). The set, the stand, the light at night and the burst are there; what is wrong is the frame: taken "all the way in" the window is 30 cells wide and the stand is 50 px, the orange smiley of the Sanctuary fills the east third, the vanometric cell stands in the clearing, two green carpet bands cross the frame, and Miel walked off to a flower bed 8 cells south (the job picks her cell). Reframed 2026-10-12 in `14-gallery.feature`: zoom 9 by `I frame the cell`, window centred west of the stand, vanometric cell hidden; the crops of `scripts/Crop-Gallery.ps1` are to be re-read off the new pictures. No candidate goes into `Art/Gallery/` before that.

**Echo and Preview, 2026-10-12.** `Art/echo-preview.png` (drawn from `Art/Preview-source.png`, no ModIcon) replaces the old `Art/echo.png`; `echo.file` points at it, `flipX: true` kept in the config (the PNG is not flipped). Echo validated at commit `8530399` (`echo_review_sha`). Regenerated with `Render-Preview.cjs`: `Mod/About/Preview.png` (668 KB), `Art/Gallery/0-preview.png` (byte-identical), `Art/Preview.ico`, `Art/ModIcon.ico`; the Preview opened at full size (echo in accent colour beside the title, ModIcon badge bottom-left, 1.6 corner). Uploaded as the GitHub social preview of the repository on 2026-10-12 (settings page checked after reload: the new Preview shows); `social_preview_sha256` is the sha256 of that file. Closing pass 2 (new ModIcon, Preview chain, social preview) is done.

**Vitrine pass of 2026-10-13 (ticket 20261013-112710-257-45af, tree 2933c07): green 4 of 4, `exitReason: passed`; the session's verdict on the nine pictures: refused again** (evidence `Tests/Pickle/runs/2026-10-13-vitrine-zoom9`, all opened). The zoom 9 reframe did not take: the stand is still about 70 px wide in a 1920 px frame, two green carpet bands still cross it (01, 02, 04, 06), Miel walks through the clearing (01, 02) or stands at the bottom edge (04), 03b frames the firefly cloud 40 cells north with the stand at the bottom edge, 05 and 06 show the whole HUD with a faint blueprint. No candidate goes into `Art/Gallery/`. Next: find why `I frame the cell` leaves the window at 30 cells, then a small ticket.

**Code review 8.m, 2026-10-13** (`cdca0a9` first commit to `341107f`, `Source/` 476 lines in 4 files, `Mod/Patches/Stand.xml`, `Mod/Defs/FuseSmoke.xml`, `About.xml`): no defect that changes behaviour. Checked: the bridge degrades to "not available" when telardo's mod or its members are missing (all reflection inside try/catch, null thoughts guarded); the launcher is spent when its light goes out, so a one-launcher stand still lights the ground, and the 900-tick interval is longer than the 300 ticks of that window, so no double fire; two watchers cannot fire twice (interval guard); saved state (`lit`, `departed`, `consumePending`) is restored before the glower reads it; `CompTick` is used where `CompTickInterval` would skip the 60-tick fuse. Cosmetic, not fixed: (1) in `CompFireworkStand.cs` the XML doc of `SetLit` ("UpdateLit compares...") sits above the `fuseSmokeDef` field; (2) if telardo's `Launch` kept throwing, each interval would silently burn one launcher per watcher session (the comment accepts it). Unverified, not provable offline: whether telardo's MapComponent saves a salvo pending at save time (a save during the 60-tick fuse could light the stand without a rocket).

**Vitrine pass of 2026-10-13, zoom 4 and 7 (ticket 20261013-175849-908-88de, tree 341107f): green 4 of 4, `exitReason: passed`; the session's verdict, all nine pictures opened** (evidence `Tests/Pickle/runs/2026-10-13-vitrine-zoom4`). The zoom was the cause: N is a half-height, a smaller N is closer. Kept as candidates in `Art/Gallery/` (full frame, recompressed to jpeg, 1.8 MB in all): `1-candidate-the-launch` (02: purple trails, sparks, warm light on the ground, the strongest), `2-candidate-the-ground-lit-at-night` (04), `3-candidate-the-reload-countdown` (05, inspect pane readable), `4-candidate-the-blueprint` (06, faint but it is what a blueprint is). Refused: 01 (the fuse smoke is a dark-blue blur at night, hard to read), 03a, 03b, 03c and 04b (the burst is not in the frame: 03 centred on (197, 158) at zoom 7 shows the stand at the bottom edge and no burst; 04b at zoom 4 shows an empty sky). Miel is in none of 01, 02 and 04 (she stands outside the frame; in 03 she is at the east edge). Open: the burst has to be framed (find its height and its delay after the launch), the fuse smoke wants a daylight hour, Miel has to be in the frame; `Art/echo-preview.png` is provisional until a gallery image is accepted (AUDIT.md 9.f). `scripts/Crop-Gallery.ps1` still carries the crops of the 2026-09 framing: obsolete, to rewrite or delete.
