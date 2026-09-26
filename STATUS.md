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
stage:        done   # workflow state names are used literally, no codes; see the 2026-09-21 audit
licence:      open
licence_at:   MIT in LICENSE and Mod/LICENSE for this mod; upstream permission is separate and not established
upstream_permission: silent
upstream_permission_at: No licence file found in the installed Fireworks dependency; no explicit consent or written refusal documented
maintainer:   Codex, responsible for this repository and STATUS.md
dependencies: declared
showcase:     complete
tested_on:    partial, 2026-09-23 and 24, in game through Pickle in the WSL: the reshaped suite passed 26 of 26 in English and in French on the 0.1.0 build; on the 0.1.1 build the English pass ran 26 of 27 (exitReason failed, the one failure a bug of the smoke step, fixed), the French pass on the same build ran 26 of 27 the same way, and the without-Ideology pass (feature 12 only) passed 1 of 1. The smoke scenarios showed the puffs thrown but not visible (the game's Smoke fades in over half a second, the fuse lasts one), so the fuse now has its own fleck (FS_FuseSmoke, d51b7dd) and the smoke pass is rerun on it; the empty-stand fix is seen on the captures of both languages. A fourth pass, vitrine (feature 14, the Workshop gallery in the ScreenshotStudio meadow), has been played three times (2026-09-25 and 26, docs/runs/2026-09-26-vitrine-4.md): 3 scenarios of 4 green, the night one red (the stand fires, its light is not seen), replayed with a tracing step; every picture is now taken at maximum zoom and cropped. The owner has validated captures 1 to 6; the fuse smoke (capture 7) is open. Final whole-suite passes on the last build are still to run. Stage stays done.
automated_on: 2026-09-21
workshop:     3806767445, created by the owner's first upload of 0.1.0 on 2026-09-23, private. The item went up ahead of the chain (stage is done, not tested), the owner's choice and not an oversight. Mod/About/PublishedFileId.txt holds the id and is committed. The description as sent carries the ATTRIBUTION and licence line.
settings_audit: not_applicable
audit_on:     2026-09-21
audit_revision: 3fa32521e3de47ce73ecc372e1809794d7de9f05
remaining:
  - resolved 2026-09-21 (preTest -> done): Pickle suite written in Tests/Pickle (four features, companion mod, wsl-ids.map, README with scope and reasons), and TESTING.md states the two passes the mod needs. Written, never run.
  - done 2026-09-21: Pickle English pass (sans-facultatifs) ran once in the WSL, 19:07: 4 features discovered, 11 scenarios, 8 played and passed, 3 @wip skipped as designed, exitReason passed, exit 0; the one @review capture was opened. Text summary in docs/runs/2026-09-21-english-first-four.md, evidence on disk and ignored by git. Fireworks staged and loaded, so the WSL staging does find it.
  - done 2026-09-21 22:28: Pickle French pass, whole suite plus feature 04: 21 of 21 passed, exitReason passed; text summary in docs/runs/2026-09-21-french-full.md, evidence (films, stills, log) on disk under Tests/Pickle/runs/ and ignored by git; all stills and films opened by the session.
  - blocking (done -> tested), gates set by the owner on 2026-09-23: (1) no scenario left in @wip: met, none in the suite; (2) every conditional scenario has run: none is conditional on a tag; the three passes must run green: English 26/26 (2026-09-23) and French 26/26 (2026-09-24) are green, the pass without Ideology is still to run (its first attempt died in the launcher after 7 hours in the queue, the ticket file having vanished, an infrastructure failure and not a test result; requeued 2026-09-24); (3) no manual test left to validate, all green: nothing is manual any more (Fireworks absent is not applicable, justified in TESTING.md), so what remains is the owner validating the captures and films, opened so far only by the session that ran them (docs/runs/2026-09-23-english.md and 2026-09-24-french.md say which).
  - resolved 2026-09-23: the bridge is now exercised: the stand's inspect line ("Ready to fire", which CompInspectStringExtra only returns once FireworksBridge.Available is true) appears on the captures of both passes, and the selecting scenario passed with no Firework Stand warning. The earlier vacuity defect of the test is closed.
  - resolved 2026-09-21: the vanilla joy giver was read (JoyGiver_WatchBuilding, JoyGiver_InteractBuilding, JobDriver_WatchBuilding, decompiled from the installed game). It never looks at fuel, so an empty stand IS offered as recreation.
  - fixed 2026-09-24 in 0.1.1 (the owner decided an empty stand gives no recreation): the mod has its own joy giver (JoyGiver_WatchFireworkStand) that refuses an empty stand, and the watching driver ends the job once the show is over; pinned by functional tests and by 07-on-their-own and 08-fuel. Not yet played in game: needs the passes on the new build.
  - superseded 2026-09-23: the suite is now 26 scenarios in 13 features, none @wip, played by three passes (see the blocking item and the section at the end); none of it has been run in this shape. The scenarios that stage a colonist's own choice (07), the sleeper (10) and the cells chosen (140,150 and the roofed patch) are guesses about the fixture colony until a run.
  - note: the run's log holds one ERROR ("Firework Stand - Pickle tests did not load any content") and one dependency-URL warning; both come from the content-less companion mod and appear the same way in the Adaptive Storage companion's log. Not the mod under test.
  - accepted: current Preview including its camera explicitly approved by the user on 2026-09-13; no camera revision required
  - done 2026-09-23 and 24: English and French in-game checks ran as scenarios (04-labels green in both languages, the inspect pane, the blueprint and the Architect menu captured in each language, none showing a raw key, an English fallback or a clipped line in the captures opened); the launch gizmo with Ideology is asserted absent in both passes, its presence without Ideology waits for the third pass. The owner's validation of the captures is still to come.
  - unverified: all nine manual scenarios and English/French UI/log checks remain required for tested; the historical publishing subset does not waive this gate
  - limitation: five existing assembly contract tests have no recorded mutation test; passing outside the game does not establish runtime behaviour
  - fixed 2026-09-24 in 0.1.1: the inspect line says nothing when nothing is loaded (functional test; the empty-stand capture to be re-taken on the new build).
  - fixed 2026-09-24 in 0.1.1, root cause found: the stand's effects were timed in CompTickInterval, which the game runs only every few ticks for a Normal ticker (Thing.DoTick), so the fuse smoke fell between two calls. Moved to CompTick (every tick), puffs a little larger and closer together (smokeInterval 12 to 8, size 0.7 to 1.0). A functional test pins the timing and a Pickle step counts the smoke puffs near the stand; whether the smoke is now visible enough is the owner's call on the new build.
  - confirmed by the owner 2026-09-24: the light is a flash at the rocket's departure, not a lamp (scenario 4).
  - accepted: orange-face mod icon deviation accepted on 2026-09-04
session:      local_db219fa5-6fea-40f2-b0fa-aa63c79d3774
updated:      2026-09-23
---

# Firework Stand â€” status

## Repository ownership and identity

Codex maintains this file after relevant changes and test runs. This task is scoped to the
single local repository above. `git rev-parse --show-toplevel` resolves to that directory;
`.git` is an ordinary local directory, and both git-dir and git-common-dir are `.git`.
This is an independent repository, not a checkout inside the former monorepo or a linked worktree.
The origin fetch and push URLs match the remote above. GitHub's repository API confirmed
`visibility: public` and `private: false` on 2026-09-13.

## Mod licence and visibility

**This mod: `open` / MIT; repository visibility: `public`.** Both licence files contain the
MIT licence, copyright 2026 Nelim. This describes the licence supplied for this mod's own work;
it does not grant rights over telardo's Fireworks or certify permission for reproduced material.

**Upstream permission: `silent`**, used here strictly for no explicit licence or permission
found, with no inference that the author is inactive. The earlier `alive` label described author
activity and was not a licence. No written refusal is documented, so `forbidden` is unsupported.
The mod is not classified `original`: it depends on Fireworks, refers to its texture at runtime,
and ATTRIBUTION.md documents a reproduced mood-outcome roll. No upstream asset files are shipped.
No licence file was found in the installed Fireworks tree during this audit; this is a local
finding, not a verification of every statement the author may have published elsewhere.

## Title decision â€” 2026-09-13

User-approved decision: the title is **Firework Stand**, without `(unofficial)`. The user
conceived the recreation-object functionality; this mod has its own distinct title and does
not present itself as an official version of Fireworks. The mod remains `open` / MIT and
`public`. The absence of documented upstream permission does not by itself require a title
suffix. MIT covers this mod's own work, not upstream rights; dependency permissions and the
reproduced mood roll remain documented separately in ATTRIBUTION.md. Preserve the attribution
and existing takedown commitment. Do not restore the suffix merely because Fireworks has no
licence file. The GitHub link remains in both About.xml's URL field and visible description.

## Tests verified on 2026-09-13

- Manual: TESTING.md contains nine functional scenarios with setup, expected outcomes and
  failure interpretation: defs, bridge/dependency absence, repeat firing, lighting, smoke,
  autonomous recreation, fuel, save/load and mood audience. These remain unexecuted in game.
- Automated: `_tools/Run-Functional-Tests.ps1` ran successfully: **25/25 passing**, exit 0,
  against the shipped mod DLL, installed RimWorld assemblies/data and Fireworks 1.6.
  Coverage includes driver override/delegate binding, glower contract, reflection bridge,
  XML comp classes/settings, fuel/dependency guard, texture case, joy references and values.
- XML: `_tools/Test-Xml.ps1` ran successfully, exit 0: **all four XML files parse**, the
  description includes the source URL, and EN/FR translation keys and placeholders match.
  The existing functional suite additionally checks Stand.xml against actual game types/defs.
- Limits: no game session or fresh source build performed in this audit. The suite validates
  the shipped DLL and contracts; it does not replace runtime tests for timers, fuel consumption,
  saving, audience filters or visual effects. Five assembly checks lack a recorded mutation run.

Reproduce from the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Test-Xml.ps1
```

## Translation audit â€” 2026-09-13

Applied the translation gate from the parent PUBLISHING.md and TRANSLATIONS.md to the
current working-tree files. Static readiness is complete; no in-game translation pass
is claimed. The historical fabrication stage above is preserved.

Inventory: all three Source/*.cs files, Mod/Patches/Stand.xml and all Mod/Languages resources.
This mod has one unversioned content root, no LoadFolders.xml, settings UI or grammar files.
Its sole patch is conditional on FireworkLauncher. Owned text consists of two Keyed inspect
messages and six Def fields: stand label/description, recreation label, job report, and the
CompRefuelable fuel label/out-of-fuel message. English comes from the existing Keyed file
and patch values; French now supplies all six DefInjected paths as well as both Keyed entries.
The reloading message preserves {0}; the description preserves literal paragraph escapes.
Technical logs, reflection names, serialized field names and metadata are excluded.

Dependency scope: installed Fireworks Workshop 2922179297, active 1.6 content selected by
its LoadFolders.xml. Read the launcher and four ThoughtDefs and decompiled
Fireworks.CompLaunchFireworks: its inherited gizmo uses LaunchFirework and LaunchFireworkDesc,
and is hidden with Ideology active. Those two English keys exist in the dependency; no French
resources are shipped there. Added French entries for both keys, the launcher label/description
and eight mood-stage fields. These shared translations also affect the original items and
memories outside the stand. Unrelated dependency rituals are outside this mod's audit.
Base-game UI and time formatting remain delegated to RimWorld's language resources.

Validation:

- `_tools/Test-Xml.ps1`: exit 0, 10 XML files parsed; nonempty entries and per-file duplicates
  checked, owned Keyed entries matched against actual Translate calls, EN/FR parameters equal.
- Parent `scripts/Check-DefInjected.ps1`: exit 0, 16 keys checked, 0 errors, no unresolved
  targets reported, against installed RimWorld 1.6 types, this mod and Fireworks 1.6.
- Reviewed the English/French wording, source fields, thought-stage handles and CompRefuelable
  handles. No duplicate English DefInjected resources are needed.
- `git diff --check`: passed. No C# or gameplay definition changes; no rebuild required.

Reproduce the injection check from the repository root (the shared script lives outside
this standalone repository):

```powershell
& ../scripts/Check-DefInjected.ps1 -TransMod ./Mod -Targets @(
    './Mod',
    'C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/2922179297/1.6'
)
```

The English/French screens, clipping, dependency-absence behaviour and Ideology variants
remain unverified in game; the procedure is in TESTING.md and tracked in remaining.
Reset affected translation fields to unchecked after changing UI code, text, Defs,
patches or language resources, then repeat this audit before entering preTest.

## Maintenance rules

Keep identity, licence, visibility, test evidence and remaining work current after each relevant
change. `stage: done` means fabrication complete, not tested in game or published. Populate
`tested_on` only after an observed in-game trial, and record partial coverage honestly.
Keep this file at repository root, outside Mod/, so it is not uploaded to Steam. Preserve the
legacy session identifier as bookkeeping, not as the identity of the current agent.

Before manual testing, research IEDs: the building is absent from the Architect menu until then.

## Preview overlay â€” 2026-09-13

Recomposed with HTML/CSS at 896 x 504 following ../STYLE_RIMWORLD.md. The existing
illustration is retained: Art/Preview-source.png remains the original, copied unchanged to
Art/Preview.png as the canonical text-free source. No replacement illustration was generated.
The retained illustration has a lower camera angle than the guide's preferred overhead style;
this pass updates the overlay, using the explicitly allowed existing illustration.

Delivered image: Mod/About/Preview.png. Composition and layout parameters: Art/preview.html.
Single colour reference: Art/preview-palette.json. Reproducible capture: Art/render-preview.cjs
(Node with playwright and sharp; local Chrome). The renderer reads the highest stable version
from the delivered About.xml, currently 1.6, and waits for document.fonts.ready and image decode.

The veil follows the large blue-black night surface. Secondary ink is a light, visibly blue
extension of that dominant family, not an average pixel colour. The orange accent comes from
the rocket's flame and warm launch pool; its warm hue separates it from the dominant blue and
secondary ink. Secondary ink is saved but not displayed: this title has no prefix/suffix or tag.
The title and existing summary are preserved verbatim, without an unofficial tag.

Actual browser fonts verified via Chrome CSS.getPlatformFontsForNode: Segoe UI Semibold for
the title, Segoe UI regular for the summary, Segoe UI Bold for the version. No fallback used.
The dark radial veil was strengthened and held through the title area after the original
firework highlight failed contrast. Final contrast minima over every pixel of the title and
summary rectangles in a text-hidden render: title 10.24:1, summary 14.23:1; badge 9.01:1.
Tag contrast is not applicable. Full evidence: Art/preview-qa.json and
Art/preview-background.png. Palette values are deliberately not duplicated here.

Visually checked at 896 x 504 and at 268 px wide (Art/preview-268.png): title and version
identifiable, no clipping or overlap, rule visible, launch stand retained on the right.
No reduced title words apply to Firework Stand. Summary is for full-size reading as the guide
specifies. Initial overlay PNG was 433789 bytes, below 900 KB; see the revision below for current evidence. Nothing published.

### Preview illustration revision â€” 2026-09-13

User found the launch-only composition ambiguous, resembling a mortar. Replaced Art/Preview.png
with a built-in imagegen edit: a large fully opened orange-gold firework now fills the right
background above the launch stand. Removed the small left burst so the title area stays quiet.
Previous source archived at Art/Preview-before-firework-burst-2026-09-13.png; the still older
Art/Preview-source.png is also preserved. Edit prompt: Art/PROMPT_Preview-burst.md.
This supersedes the earlier statement that no replacement illustration was generated.

Re-evaluated the palette on the edited source: blue-black night remains dominant, the blue
secondary ink remains appropriate, and the new orange-gold burst reinforces the warm accent's
connection to the subject. Existing Art/preview-palette.json values are retained deliberately.
Re-rendered Mod/About/Preview.png using Art/preview.html and Art/render-preview.cjs. Name,
summary, no-tag decision and version 1.6 are unchanged. Segoe UI regular/Semibold/Bold confirmed.
Current QA: 896 x 504, 564219 bytes; minimum contrast title 12.66:1, summary 12.42:1,
badge 9.01:1. Art/preview-qa.json, preview-background.png and preview-268.png refreshed.
Visually inspected the source and final composition at full size and 268 px: the expanded
firework is immediately recognisable, title and badge are clear, no text overlap or clipping.
Nothing published.

## Ordered workflow audit â€” 2026-09-13

This section supersedes historical global-stage claims without deleting their evidence.
Previous stage: `done`. Retained stage: `modIcon`, meaning **ModIcon generated**
(`ModIcon gÃ©nÃ©rÃ©e` in the requested workflow). `done` means ready for final game validation;
`tested` means all applicable functional scenarios actually passed in game.
The user's supplied workflow takes precedence over the parent guides, including the rule
that the options gate does not require in-game testing.

### Audited tree and concurrent work

Standalone repository: `C:/Users/nelim/Documents/rimworld/FireworkStand`; distributed root:
`Mod/`. Git top-level, git-dir and git-common-dir confirm an ordinary independent repository.
Initial HEAD was `332015641e31d6e819362e7a246966c65bca8e65`; during the audit another change
advanced HEAD to `8ff9fdaca496e908e42bf0574a970d5a8b13e9f7` and revised the Preview.
The final image was inspected again at full size and 268 px. No Source/, Mod/Patches/ or
functional-suite differences against the initial revision were found. Existing edits were
preserved; this audit changes only STATUS.md and creates ignored build output under .build/audit.

Local changes at final inventory: About.xml, Preview.png, README.md, STATUS.md, TESTING.md,
_tools/Test-Xml.ps1; untracked Art/PROMPT_Preview-burst.md,
Art/Preview-before-firework-burst-2026-09-13.png, Art/Preview.png, Art/preview-268.png,
Art/preview-background.png, Art/preview-palette.json, Art/preview-qa.json,
Art/preview.html and Art/render-preview.cjs. Earlier untracked French resources and the
CHANGELOG change were incorporated into the intervening commit, not removed by this audit.
Results apply to this working tree, not merely the clean commit.

### Transition decisions (evaluated in order)

| Destination | Finding |
| --- | --- |
| horsMonoRepo | Validated: independent repository; configured GitHub origin; live remote HEAD returned 332015641e31d6e819362e7a246966c65bca8e65 and API returned public/main. At least one pushed commit is established; this does not claim all local changes were pushed. English initial documentation exists, and LICENSE/ATTRIBUTION distributed copies are byte-identical to their root copies. Identity nelim.fireworkstand / Firework Stand / Rimworld-Firework-Stand / FireworkStand is coherent. Preserve the recorded title and own-work MIT/public decision, with upstream permission separately silent; no new upstream permission is inferred. |
| ModIcon generated | Validated: implementation present with no pending feature work; isolated rebuild succeeds and exactly matches the shipped DLL. ModIcon is PNG, 128 x 128, 24000 bytes, directly inspected; existing accepted mascot decision retained. The known empty-fuel inspect wording is tracked as a non-blocking rough edge, not an unfinished feature. |
| Preview generated | Defect observed: PNG format/size pass (896 x 504, 564219 bytes), but the actual composition has a visible horizon around mid-frame, a large sky region and upright figures seen from behind with little top-down view. This is a low oblique cinematic scene rather than the guide's high overhead camera. The revised large burst makes the subject clear but does not change this camera. This blocks the transition; it is not a missing historical generation record or missing screenshot comparison. |
| preOptions | Independent palette/readability and English title checks pass: blue secondary versus orange accent, legible title/version at 268 px, no clipping, no linking words or prefix/suffix to reduce under the recorded title decision. Additional observed description defect: the source URL is bare and appears before THANKS, rather than the final [url=...]Source code on GitHub[/url] required by PUBLISHING.md. |
| options | Independently validated as settings_audit: not_applicable; rationale and scope below. |
| l10n | Independently validated statically: owned/reused English and French text inventory reviewed, 10 XML files parse and 16 DefInjected paths resolve with zero errors. Game display remains unverified. |
| preTest | Independently validated: Fireworks packageId telardo.Fireworks and 1.6.0.0 installation match dependency/loadAfter and the guarded launcher patch. Mod declares only RimWorld 1.6. No local LoadFolders is needed. Fireworks selects 1.6 plus optional Ideology data through its own LoadFolders; Ideology is not required by this mod. |
| done | Independent test/scenario criteria pass: 25/25 automated checks, XML checks and DefInjected validation passed against delivered content; nine written scenarios include setup, actions and expected results. This does not override earlier blocked transitions. |
| tested | Unverified: no game session was executed or observed; no current Player.log or FR/EN interface validation, fresh-colony or existing-save run is certified. All nine applicable scenarios must pass, regardless of TESTING.md's narrower historical publishing subset. |

### Settings audit

Reviewed all three C# sources and the complete patch/content inventory. Shot interval (900),
launch delay (60), memory radius (20), flash duration (240), smoke interval (12), fuel capacity
(10), recreation chance/duration/range and construction cost are authored balance/definition
values, not a documented player configuration contract. No concrete need for global controls
is established by this mod's focused scope; exposing every constant would invent settings.
Per-building fuel management already uses the native CompRefuelable controls, including the
allowed auto-refuel toggle. The inherited Fireworks launch gizmo is a gameplay action, not a
settings route. There is no Verse.Mod subclass, ModSettings class, settings window/category,
MainButtonDef or configuration shortcut in this mod. Thus no empty page or hidden shortcut
needs to be supplied. Settings input validation, reset, migration and configuration persistence
are not applicable; building save/load is a separate unverified functional scenario.
No RIMMSQOL or other customization integration was tested or is claimed compatible.

### Executed checks and limitations

- Read parent AGENTS.md, PUBLISHING.md, STYLE_RIMWORLD.md, MOD_SETTINGS.md and TRANSLATIONS.md.
- `dotnet build Source/FireworkStand.csproj --no-restore -t:Rebuild -p:OutputPath=C:/Users/nelim/Documents/rimworld/FireworkStand/.build/audit/ -v:minimal`: exit 0, zero warnings/errors, SDK 8.0.424. Initial sandbox SDK-access failure was resolved by rerunning with the necessary access; it was an environment failure, not a source defect.
- SHA256 of both isolated rebuild and shipped Mod/Assemblies/FireworkStand.dll:
  `F1525A952734A95581EF9000323CE21742DD6003FC80D62215FB670D7086C62D`.
  Delivered assembly references only mscorlib, Assembly-CSharp (1.6.9676.17735) and UnityEngine.CoreModule. Lib.Harmony is an unused build PackageReference, not a missing runtime dependency; removal is optional cleanup.
- `powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1`: exit 0, 25/25 passed; 16130 installed game types scanned. This exercises construction and assembly/definition contracts, not a running colony.
- `powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Test-Xml.ps1`: exit 0, 10 XML files parsed, owned EN/FR keys and {0} parameters match actual Translate calls. Its source-link assertion accepts a bare URL, so passing it does not validate the prescribed BBCode presentation.
- `& ../scripts/Check-DefInjected.ps1 -TransMod ./Mod -Targets @('./Mod','C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/2922179297/1.6')`: exit 0; 30 patch operations, 11625 indexed defs, 16 checked keys, 0 errors. Owned English Def source values and dependency English LaunchFirework/LaunchFireworkDesc exist; French resources and nested CompRefuelable/thought paths were read directly. Technical logs and metadata are excluded with justification.
- Direct PNG inspection: current Preview SHA256
  `5B41D328B0A7C47F590E70133E9A214CFF145DA1AB3444964C78274F9D304282`.
  Palette JSON and HTML reviewed. Historical contrast/font measurements were not rerun and are not claimed as new measurements; the final rendered text was inspected directly.
- `git diff --check`: passed (line-ending notices only).
- Game execution, runtime dependency-absence behaviour, Ideology gizmo variants, French/English layout and logs, fuel/timers/effects/audience behaviour, and save/reload remain unverified. No interactive environment was used for these checks; installed assemblies alone cannot establish their results.

### Next transition and separate follow-up

Strictly necessary for ModIcon generated -> Preview generated: revise the Preview camera to
match the high oblique overhead style, then inspect the delivered PNG and recheck its format,
dimensions and size. No image was generated or modified by this audit.
The final formatted GitHub description link is a later preOptions requirement.
Keep settings/l10n/dependency/test validations unless subsequent changes affect their inputs.

Optional/non-blocking: remove unused Lib.Harmony build reference; correct the CHANGELOG's
"quarter hour" wording (900 ticks is 21.6 in-game minutes); retain the known empty-fuel
"Ready to fire" inspect issue for triage. Missing mutation runs are a test-method limitation,
not a required extra gate. No publication, source change or history rewrite was performed.

## Preview acceptance â€” 2026-09-13

The user explicitly approved the current Preview ("je valide cette preview"). This decision
supersedes the camera blocker and camera-revision requirement in the historical audit above.
The accepted file is Mod/About/Preview.png, SHA256
`5B41D328B0A7C47F590E70133E9A214CFF145DA1AB3444964C78274F9D304282`,
unchanged from the directly inspected final image. Its camera is an accepted exception;
do not regenerate or revise this image merely to enforce the guide's overhead camera.

Stage advances from `modIcon` (ModIcon generated) to `preview` (Preview generated /
Preview generee). Showcase is complete. The next transition to `preOptions` still requires
the prescribed final formatted Source code on GitHub link in About.xml's description;
its bare URL remains present on this check. This approval does not waive that separate item.
The independently established settings, localization, dependency and automated-test results
remain valid. In-game validation remains unverified, and tested_on stays empty.

HEAD remains `8ff9fdaca496e908e42bf0574a970d5a8b13e9f7` with the previously recorded
local modifications. Only STATUS.md was changed for this approval; the image, source,
metadata and historical audit results were preserved. No build or gameplay retest is
needed for this decision-only update.

## Source-link correction â€” 2026-09-13

Replaced the bare SOURCE CODE block in Mod/About/About.xml with the prescribed
[url=https://github.com/vbardales/Rimworld-Firework-Stand]Source code on GitHub[/url]
at the very end of the English description, after the credits. The metadata URL is unchanged.
This resolves the remaining preOptions defect identified in the historical audit.

Validation: _tools/Test-Xml.ps1 rerun successfully (exit 0, 10 XML files, matching EN/FR
keys and placeholders). A separate exact check confirmed the description ends with the
BBCode link constructed from its metadata URL. The shipped DLL and accepted Preview hashes
remain identical to the audited values. No source, gameplay definition or translation resource
was changed, so the previous build, 25 automated checks and DefInjected results remain valid.

Stage advances from `preview` (Preview generated) to `done`: the accepted Preview and corrected
description now complete the cumulative gates through preOptions, options, l10n, preTest and
done. The justified settings_audit: not_applicable and static localization validations are
preserved. This supersedes the earlier source-link blocker and retained-stage conclusions.
All applicable in-game scenarios, FR/EN interface checks and logs remain unverified;
`tested_on` remains empty. Nothing was published and no game test is claimed.

Audited HEAD is still 8ff9fdaca496e908e42bf0574a970d5a8b13e9f7 with existing local changes.
This correction modifies only Mod/About/About.xml and STATUS.md and preserves prior evidence.

## Ordered workflow audit â€” 2026-09-21

Previous stage: `done`. Retained stage: **`preTest`**. Applies `rimworld/AUDIT.md` as revised on
2026-09-21. The `stage` field uses the workflow's own state names, so no code table is needed.

The step-down is not a regression of the mod: nothing validated on 2026-09-13 has changed. The
revised workflow adds one criterion to `preTest -> done` that this repository has never been asked
to meet: Pickle (Gherkin) tests **written**, with their scope justified. Their execution is not
required for `done`; it belongs to `done -> tested`.

### Audited tree

Standalone repository `C:/Users/nelim/Documents/rimworld/FireworkStand`, distributed root `Mod/`.
HEAD `3fa32521e3de47ce73ecc372e1809794d7de9f05`; `git status` clean, no local modification.
`git ls-remote origin HEAD` returns the same SHA, so nothing is unpushed. Since the previous audit
(`8ff9fda`) three commits touched only the copyright holder's and maintainer's spelling ("Nelim")
and `.gitignore`. No tag and no release exist yet (they belong to `tested -> prepublished`).
No RimWorld was launched, and none was running (`Get-Process RimWorldWin64`: 0).

### Transition decisions (evaluated in order)

| Destination | Finding |
| --- | --- |
| horsMonoRepo | Validated. Independent repository, origin `Rimworld-Firework-Stand` configured and pushed (remote HEAD = local HEAD). STATUS.md initialised. Public visibility and `open` / MIT with upstream `silent` are the recorded, user-approved decision of 2026-09-13; unchanged. packageId `nelim.fireworkstand`, name, repository and folder are coherent. README, ATTRIBUTION, CHANGELOG and LICENSE are in English; the distributed ATTRIBUTION.md and LICENSE are byte-identical to the root copies (SHA256 compared). |
| ModIcon generated | Validated. Isolated rebuild of `Source/FireworkStand.csproj` exits 0 with 0 warnings and 0 errors, and its SHA256 equals the shipped `Mod/Assemblies/FireworkStand.dll` (`F1525A95â€¦C62D`). `Mod/About/ModIcon.png` is PNG, 128 x 128, 24000 bytes, opened and looked at: the accepted mascot. |
| Preview generated | Validated. `Mod/About/Preview.png` is PNG, 896 x 504, 564219 bytes (< 1 MB), SHA256 `5B41D328â€¦4282`, identical to the image the user approved on 2026-09-13. Opened and looked at: title, rule, summary and version badge readable, no clipping. |
| preOptions | Validated. Blue-black veil against an orange accent (`Art/preview-palette.json`), clearly distinct. English description present and ends with `[url=https://github.com/vbardales/Rimworld-Firework-Stand]Source code on GitHub[/url]`, matching `<url>` and the remote. No prefix, suffix or linking word to handle under the recorded title decision. |
| options | Validated as `settings_audit: not_applicable`. Grep of `Source/*.cs` and `Mod/`: no `Verse.Mod` subclass, no `ModSettings`, no `MainButtonDef`, no settings window, so there is neither an empty page nor a shortcut. Rationale unchanged from the 2026-09-13 section. No in-game check was required or claimed. |
| l10n | Validated statically. `Test-Xml.ps1`: 10 XML files parsed, EN/FR keys and placeholders match. `Check-DefInjected.ps1`: 30 patch operations, 11625 defs indexed, 16 keys checked, 0 errors. Both Translate calls (`FireworkStand.Ready`, `FireworkStand.Reloading`) have EN and FR entries; the only other player-facing strings are Def fields (English source in the patch, French in DefInjected). The `Log.Warning` texts are technical logs and stay English. |
| preTest | Validated. Only `telardo.Fireworks` is declared as `modDependencies` and it is what the code and the guarded patch reach for; `loadAfter` lists Ludeon.RimWorld and it. Only RimWorld 1.6 is supported and no `LoadFolders.xml` is needed. Ideology is not required. |
| done | **Defect: not met.** Met: written scenarios (nine, with setup, expected result and failure reading, in TESTING.md), automated tests green, XML tests green, results tied to the shipped DLL. Not met: there is no `Tests/` folder, no Pickle feature, and neither TESTING.md nor this file gives a justification of the Pickle scope or the number of passes the mod needs. The audit does not write tests or invent that justification. |
| tested | Not reached. Unverified: nothing has been played in game. |

### Checks executed on 2026-09-21

- `dotnet build Source/FireworkStand.csproj --no-restore -t:Rebuild -p:OutputPath=<temp>`: exit 0, 0 warnings, 0 errors; DLL hash equal to the shipped one.
- `powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1`: exit 0, **25/25 passing**, 16130 game types scanned. It reads the compiled game and Fireworks assemblies; it does not run a colony.
- `powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Test-Xml.ps1`: exit 0, 10 files.
- `& ../scripts/Check-DefInjected.ps1 -TransMod ./Mod -Targets @('./Mod','C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/2922179297/1.6')`: exit 0, 16 keys, 0 errors.
- Direct opening of `Preview.png` and `ModIcon.png`; SHA256 comparison of the distributed licence and attribution copies.
- Not run, and not claimed: any test in game, any Pickle run, the FR/EN interface, the logs, save/reload.

### Next transition and separate follow-up

Strictly necessary for `preTest -> done`: write the Pickle suites for what only a running game can
show, or record why none applies, and state in TESTING.md how many passes the mod needs (bare set,
plus one with Fireworks' optional Ideology data if that is judged to change anything). Keep the
scope small: the 25 outside-the-game tests already prove the contracts, and a scenario that repeats
one of them does not belong in Gherkin. Running the suites is not required for this step.

Everything validated above stays valid; a change to `Source/`, `Mod/Patches/`, the language
resources or the About description would reset only the checks that read them.

Optional, not blocking: the description opens with only the second half of the removal notice
("â€¦ request its removal â€¦"), so "its" has no antecedent; the recorded 2026-09-13 decision drops the
`(unofficial)` suffix but says to keep the commitment, and it may read better with its first
sentence. Remove the unused `Lib.Harmony` PackageReference from `Source/FireworkStand.csproj`.
Correct the CHANGELOG's "every quarter hour" (900 ticks is about 21.6 in-game minutes). The
"Ready to fire" inspect line on an empty rack stays a known rough edge.

## Pickle suite written â€” 2026-09-21 (preTest -> done)

Stage advances from `preTest` to **`done`**. The only blocker of the audit above was the missing
Pickle (Gherkin) suite with a justified scope; it is now written. Nothing else changed: no source,
patch, language resource or About description was touched, so the earlier validations stand.
Nothing was run in RimWorld and no Pickle run was started (running is a `done -> tested` criterion,
and would need the machine lock and `scripts/Run-PickleWsl.ps1`).

Added: `Tests/Pickle/Mod` (companion mod "Firework Stand - Pickle tests", packageId
`nelim.fireworkstand.pickletests`, never published), four features, `Tests/Pickle/wsl-ids.map`
(Fireworks' Workshop id for the staging), `Tests/Pickle/README.md`, and a "Pickle (Gherkin) suite"
section in TESTING.md.

- `01-loads`: mod loaded and after Fireworks; the guarded patch added the ThingDef, JoyKindDef, JobDef and JoyGiverDef; the stand's joyKind; English labels; a save loads with no error and no `Firework Stand]` warning.
- `02-stand-on-map`: a built stand ticks 300 ticks without error or bridge warning; save round trip and reload; one `@review` capture.
- `03-watching` (`@wip`): a colonist with low Joy is expected to take `FS_WatchFireworks`. A hypothesis, flagged as such in the file.
- `04-french-names` (`@wip`): French stand, recreation type and launcher labels, for a French pass.

Scope justification, in Tests/Pickle/README.md and TESTING.md: what the 25 outside-the-game tests
prove is not repeated; Fireworks absent (hard dependency, nothing to play), repeat firing, light,
smoke, fuel count, the mood audience filter, the reload timer and the Ideology gizmo variants stay
manual, because no generic Pickle step loads a stand with launchers or reads its comp and a custom
step assembly would rest on guesses. **Passes needed: two** (English without optional mods, French
for feature 04): no optional mod and no incompatibility is declared, so no further pass applies.

Checks after the change: `_tools/Test-Xml.ps1` exit 0 (10 files); `_tools/Run-Functional-Tests.ps1`
exit 0, 25/25. Each step used in the features was matched against the expressions compiled into the
installed Pickle (`RimWorks.Pickle.Vanilla.dll`); that is a comparison, not a run.

Next transition (`done -> tested`): play the scenarios in game, the nine of TESTING.md and the two
Pickle passes, read `exitReason` first, open the capture, check the logs and FR/EN interface. The
Pickle suite is committed with this change only if the user asks; at the time of writing it is an
uncommitted working-tree addition on HEAD `3fa3252`.

## First Pickle run â€” 2026-09-21 (English pass)

Run through `scripts/Run-PickleWsl.ps1 -Mod FireworkStand` after queueing (two earlier tickets were
lost: the first to a `Indexation impossible dans un tableau Null` error in the shared script during
the wait, the second to the default 90-minute `-MaxWaitMinutes`; nothing ran on either). The lock
was taken by this session, the game ran in the WSL under Xvfb, the lock was released. The game was
identified as ours by `-pickle-run=Firework Stand - Pickle tests`. No Windows RimWorld was touched.

Read in this order: `exitReason: passed` (before the counts), then 4 features discovered
(`01-loads`, `02-stand-on-map`, `03-watching`, `04-french-names`), 11 scenarios: 8 passed, 0 failed,
3 skipped (the three `@wip`, as designed), 0 flaky; report time 19:08, after the run's start.
"Les 12 mods mis en scene sont tous charges", Fireworks included. The `@review` capture
`firework-stand-empty.png` was opened: the stand sits on the map in daylight, drawn from Fireworks'
launcher texture, interface visible. It shows the stand exists and draws; it says nothing about the
light, the smoke or a salvo.

Limits of this run, none of them a defect of the mod: the stand was never loaded with launchers,
never watched, never fired; the bridge was probably never asked (see `remaining`); the French pass
and all nine manual scenarios are unplayed. Text summary: `docs/runs/2026-09-21-english-first-four.md` (evidence on disk, ignored by git)
(summary, junit, the capture); the archive in `pickle-reports-archive/` will be pruned.

Stage stays `done`. Unchanged and still uncommitted on HEAD `3fa3252`: STATUS.md, TESTING.md and
`Tests/`.

## Manual scenarios written as Pickle scenarios â€” 2026-09-21

Request: write the manual tests with Pickle so that the maintainer only validates captures or
films. Done, not run. `Tests/Pickle` now holds eleven features and a step assembly
(`Source/FireworkStandSteps.cs`, built into `Mod/Pickle/Assemblies/`, committed because the staging
mirrors that folder). It references the game and Pickle only, and every step text starts with
"Firework Stand:" to avoid collisions with other suites.

Mapping to TESTING.md, in TESTING.md and in `Tests/Pickle/README.md`: scenarios 1, 3, 4, 5, 6, 7, 8
and 9 each have a feature with assertions before the capture (`@film` on five of them), and a
French-and-English inspect-pane capture covers the translation checks. The English label check was
removed from `01-loads` so that the whole suite runs unchanged in French. `03-watching` (`@wip`) was
replaced by `07-on-their-own`, the vanilla joy giver having answered its first guess.

Staying manual, with the reason in the README: scenario 2's negative half (hard dependency), the
Ideology gizmo variants (the WSL mounts every DLC), the Architect menu entry, and the missing
line-of-sight test in the audience filter.

Checks made: the eleven features parse with Pickle's own Gherkin parser; the step assembly builds
(0 warnings, 0 errors); each generic step used was matched against the expressions compiled into the
installed Pickle. Not made: any run of the widened suite. One ticket for it (pid 36520,
`-MaxWaitMinutes 480`) was queued before the suite was finished and survived a session restart; it
plays whatever is on disk when its turn comes, and its result is not yet read.

Stage stays `done`.

## Widened Pickle suite, two runs â€” 2026-09-21

Both runs are the suite of commit `49c36d8` (eleven features, the step assembly), through
`scripts/Run-PickleWsl.ps1`, in the WSL under Xvfb, on the minimal set (12 staged mods, all loaded,
Fireworks included). The game was identified as ours by `-pickle-run=Firework Stand - Pickle tests`.

- **English, 20:28 to 20:38, ticket pid 36520:** 21 scenarios discovered, 18 passed, 1 failed, 2
  skipped (feature 04, `@wip`), `exitReason: failed`, launcher exit 1. **Its report was lost:** it
  was archived, then pruned by later runs (the archive keeps 15) before this session, which had not
  been notified of the end of that ticket, went to read it. Which scenario failed, its message, its
  captures and its films are unknown. The launcher's output kept only the totals.
- **French, 22:28 to 22:38, ticket pid 29288:** 21 of 21 passed, 0 failed, 0 skipped, `exitReason:
  passed`, exit 0. Report copied at once, evidence on disk in `Tests/Pickle/runs/2026-09-21-french-full/` (ignored by git), text summary in `docs/runs/2026-09-21-french-full.md` (summary, junit,
  messages, Player.log, five films; the sixteen full-size stills stay on the machine and are ignored
  by git). **All sixteen stills and the five films were opened.** The dashboard state was polled
  during the run so that nothing else could be lost.

What the captures show, read directly (French pass): the loaded stand at rest reads "feux d'artifice
chargÃ©s : 4 / 10" and "PrÃªte Ã  tirer"; after a salvo "Rechargement : 0.3 heures" (decimal point as the game
formats it); the empty stand reads "0 / 10", "Aucun feu d'artifice chargÃ© (10x lanceur de feux
d'artifice)" and, beside them, "PrÃªte Ã  tirer", **the known rough edge, confirmed in French**; no raw
key, no English fallback, no clipped line, no broken accent in any of them. The night stills show the
ground around the stand warmly lit as the rocket leaves and dark before and after. The audience
capture matches its scenario: the stand, the colonist outdoors beside it, the roofed patch with the
sleeper (Z icon) and the colonist under it, a burst overhead. The fuse and puff stills show sparks;
the thread of smoke is not clearly visible at the stills' scale. The blueprint capture shows the
ghost of the stand, not a watching area.

Defects found in the suite, not in the mod: (1) six of the sixteen stills, all taken inside filmed
scenarios, carry the film's own 480x270 frame in the bottom-left corner; the suite now films without
stills and takes stills in a twin scenario (unplayed); (2) every film opens with about five seconds
of the main menu and shows the stand small; (3) the blueprint scenario's title promised a watching
area it does not show (title corrected).

Open: the lost English failure. Only a second English run can say whether it depends on the language
or is intermittent. A ticket for it is queued. Nothing here changes the stage: `done`.

## Groundwork for prepublished â€” 2026-09-21

Stage stays `done`; `tested` is not reached (the English Pickle pass has to run again and be green, and the captures
and films have to be validated by a person). Prepared meanwhile, documents only, no source or Preview change:

- `Mod/About/About.xml`: the description lacked the line pointing to `ATTRIBUTION.md` and the licence that the
  prepublished checklist puts between `THANKS` and the source link. Added; the description still ends with the
  `[url=...]Source code on GitHub[/url]` link. `_tools/Test-Xml.ps1` still exits 0. **The shipped DLL is unchanged**,
  so the build, the 25 functional tests and the Pickle runs are not invalidated by this. The Steam description is
  sent only at creation, so nothing to correct there yet.
- `CHANGELOG.md`: "every quarter hour" corrected to 900 ticks, about twenty-two in-game minutes (the optional point
  noted in the audit).
- `PUBLICATION.md` (new, draft): release notes, dependencies and DLC, the order of the Workshop captures and what to
  check on each (a corpse of the test colony sits beside the stand in almost every capture), the content boxes, one
  thank-you message for telardo under 1000 characters, and what to do right after the upload.

Not done and not to be done without the owner: tag `v1.0.0`, the GitHub release, the Steam upload, the message to
telardo. All uncommitted at the time of writing.

## New gates for tested, and what was done about them â€” 2026-09-23

The owner prepublished 0.1.0 (Workshop item 3806767445, private; recorded in `workshop:`), created the
`PublishedFileId.txt`, and asked for three new verifications before `tested`: **no scenario in `@wip`, every
conditional scenario played, no manual test left to validate (all green).** Stage stays `done`.

- **No `@wip`.** The only one was the French-only feature. It is replaced by `04-labels`, which reads the active
  language (a new step) and asserts the label written for it, so the same scenario is green in the English pass and
  in the French pass and fails, naming the language, in a pass it has no value for. No scenario carries a tag that
  skips it.
- **No manual test left.** The four that were manual: Fireworks absent (declared not applicable, the mod cannot be
  active without its hard dependency; the guard is proved outside the game), the Ideology launch gizmo (now
  `12-launch-gizmo`, one scenario that asserts the gizmo is offered exactly when Ideology is inactive, played in a
  third pass whose map `wsl-deps.sans-ideology.map` leaves the DLC out), the Architect menu (now `13-architect-menu`,
  reading `Designator_Build.Visible` before and after IEDs), and the line-of-sight test (not a test: the mod
  deliberately has none). What is left is the owner validating captures and films.
- **Every conditional scenario played.** Nothing is conditional on a tag, so this comes down to: the three passes
  must all run, on the suite as it stands, and be green.
- New steps in `FireworkStandSteps.cs` (now 27): the label by language, the launcher gizmo, select-by-def-and-cell,
  the research unfinished, the Architect menu lists or hides the stand, open the Architect category. The assembly
  builds with 0 warnings; the 13 features (26 scenarios) parse with Pickle's own parser; nothing has been played.
- `Tests/Pickle/Run-Passes.ps1` plays the three passes in turn through the launcher and copies each report into
  `Tests/Pickle/runs/` as soon as the launcher returns, because the first English run was lost for want of that.
- `CHANGELOG.md` now starts with `# 0.1.0`, the creation of the `PublishedFileId.txt` and the item.

The audit's rule holds: a green scenario shows the trajectory ran, not that an image shows anything. `tested` waits
for the runs and for the owner's validation of what they produced.

## Review of the suite, and where the evidence lives â€” 2026-09-23

A code review of the Pickle work found five things, all fixed before any run:

- **Language step (would have failed the French pass):** `04-labels` compared the active language's folder name with
  "French", but Core names it "French (FranÃ§ais)". The step now matches the English name or the English name followed
  by " (". Caught before the pass ran.
- **Evidence copy took other mods' captures:** `Run-Passes.ps1` selected stills and films by "newer than the moment the
  pass queued", in a screenshots folder every mod writes to. It now takes only names this suite's features give
  (`I take a screenshot "..."`, the feature titles for films) and only within the hour before the run ended.
- **One failed copy stopped the next passes:** each pass is now wrapped and the error said out loud.
- **`SelectStand` duplicated `SelectThing`:** it now calls it.
- **Evidence was in git.** Rule from the owner: evidence stays on disk and out of git, a text summary goes in
  `docs/runs/`. `Tests/Pickle/runs/` is untracked and in `.gitignore` (the files stay on disk), the two earlier runs have
  text summaries in `docs/runs/`, and `Run-Passes.ps1` writes both from now on.

The assembly was rebuilt (27 steps, 0 warnings). Nothing has been played in the reshaped suite. Stage stays `done`.

## The two passes of the reshaped suite â€” 2026-09-23 and 24

Through `Tests/Pickle/Run-Passes.ps1`, in the WSL under Xvfb, on the suite of commit `29b2f2d` (26 scenarios in 13 features,
27 custom steps, none `@wip`):

- **English (2026-09-23, 19:28 to 22:21 with the wait): 26 scenarios, 26 passed, 0 failed, 0 skipped, `exitReason: passed`.**
- **French (2026-09-24, to 00:14): 26 passed, 0 failed, `exitReason: passed`.** The game exited with 137 after writing a
  complete report, which the launcher kept. The language step that a review had corrected before the run (Core's
  "French (FranÃ§ais)" folder name) did its job: `04-labels` is green in both languages.
- **Without Ideology: not played.** The launcher died after about seven hours in the queue on a ticket file that had been
  deleted under it. The pass was requeued.

What the captures opened by the session show (English pass unless said): at night the ground around the stand reads
"Dark (0%)" before the salvo, "Lit (50%)" with a warm halo and a rocket trail as it leaves, in a clean image with no film
frame in the corner; the Recreation category lists Chess, Poker, Billiards and Horseshoes before IEDs and adds the
"Firework stand" entry after it (and "Rampe de feux d'artifice" among the Loisirs in French); a selected launcher shows
only the "Allow" gizmo with Ideology active; the audience capture shows the stand, the colonist outdoors beside it, and the
sleeper and the colonist under the roofed patch, with a burst overhead; the puff capture shows a rocket trail and sparks;
the empty stand still reads "Ready to fire" beside a 0 / 10 gauge (the known rough edge). Nothing was validated by the owner.

Evidence trimmed under the root rule: the first French run's folder was deleted as superseded, the new runs keep only their
raw result, minified stills and the films (English only); see `docs/runs/`. Stage stays `done`.

## Version 0.1.1: three defects fixed at the root â€” 2026-09-24

Decided with the owner after the first full in-game runs: fix the fuse smoke, the "Ready to fire" line on an empty stand,
and make an empty stand give no recreation. Source changes (the mod's DLL is new, `Mod/Assemblies/FireworkStand.dll`):

- **Root cause of the invisible smoke, read from the game:** `Thing.DoTick` runs `Tick()` on every tick but `TickInterval()`
  only every `UpdateRateTicks` ticks, and all the stand's effects were in `CompTickInterval`. The effects are now in
  `CompTick`. Puffs: `smokeInterval` 12 to 8, size 0.7 to 1.0.
- **Empty stand, no recreation:** `JoyGiver_WatchFireworkStand` (a subclass of the vanilla watch-building giver, no Harmony)
  refuses a stand with nothing loaded; `JobDriver_WatchFireworks` ends the job once `CompFireworkStand.ShowIsOn()` is false
  (no fuel and the last rocket long gone).
- **"Ready to fire":** `CompInspectStringExtra` returns nothing when the stand has no fuel.
- `Stand.xml`: `giverClass` names the new class, `smokeInterval` is 8. No change to saved fields.

Checks made: the mod builds (0 warnings, 0 errors); `_tools/Run-Functional-Tests.ps1` now has **31 tests, all passing**,
six of them new, and those six were seen to fail against the previous version (its DLL and patch taken from HEAD); the two
existing tests that named the vanilla giver class were adapted (they now resolve the mod's giver and compare through its
nearest vanilla class) without weakening them; `_tools/Test-Xml.ps1` and `Check-DefInjected.ps1` pass. Pickle side: a step
that counts smoke puffs (28 steps), an assertion in `06-fuse-and-launch`, a scenario for the empty stand in
`07-on-their-own`, the watcher having stopped in `08-fuel`, and the pass without Ideology reduced to `12-launch-gizmo` (the
fixture throws on every tick without Ideology, see docs/runs/2026-09-24-sans-ideology.md).

**Nothing has been played on the new build.** The runs of 2026-09-23 and 24 are for the previous DLL and prove nothing
about this one; the three passes must be replayed, and the smoke, the empty-stand line and the empty-stand behaviour
looked at again. The item on Steam has the old DLL: an update upload is needed. Stage stays `done`.

## Owner validations of captures and films — from 2026-09-25

One item at a time, each with the list of what to look for. A validation is the owner's, recorded here with its date; the run
that produced the image is in `docs/runs/`.

- **Capture 1, the empty stand's inspect pane, English (first 0.1.1 English run, `docs/runs/2026-09-24-english-0-1-1.md`):
  validated by the owner on 2026-09-25.** No "Ready to fire" on an empty stand; "No fireworks loaded (10x firework launcher)"
  and a gauge at 0 / 10. Remark: the label "fireworks loaded" wanted a capital; fixed in `f2ccb52` (English and French), so the
  image on disk predates it and is not re-taken for this validation.
- The owner subscribed to the GitHub repository (Watch, All activity) on 2026-09-25. The Workshop comment subscriptions and the
  "Watch all activity" of the item and of Fireworks are still to come with the public item.
- **Capture 2, the ground lit at night as the rocket leaves, English (`docs/runs/2026-09-24-english-0-1-1.md`): validated by the
  owner on 2026-09-25.** A warm pool of light around the stand on dark ground, "Lit (50%)", 23h, the interface visible with no
  film frame: the light is a flash and not a lamp.
- **Capture 3, the audience, English (`docs/runs/2026-09-24-english-0-1-1.md`): validated by the owner on 2026-09-25.** The stand
  with the launch puff above it, the colonist outdoors, the roofed patch with the one under it and the sleeper (Z), the watcher at
  the door. Her question, whether the show should wake the sleeper, goes to the backlog (monorepo `BACKLOG.md`, commit
  `678722f6`): Firework Stand does nothing about sleep, and what vanilla or Fireworks do about noise was not read.
- **Capture 4, the stand counting down its reload, English (`docs/runs/2026-09-24-english-0-1-1.md`): validated by the owner on
  2026-09-25.** "Reloading: 0.3 hours", the count and the gauge at 3 / 10, the watching areas drawn round the selected stand.
  The count's label was still lowercase on this image (fixed in `f2ccb52`).
- **Capture 5, the blueprint of the stand, English (`docs/runs/2026-09-24-english-0-1-1.md`): validated by the owner on 2026-09-25.**
  The translucent ghost of the stand, "Firework stand (blueprint)". She asked what "IED" is: the vanilla research project IEDs
  (improvised explosive devices), the stand's `researchPrerequisites`, which is why the Architect menu hides the stand until it is done.
- **Capture 6, the Recreation category once IEDs is researched, English (`docs/runs/2026-09-24-english-0-1-1.md`): validated by the
  owner on 2026-09-25, with one remark:** the box slightly overflows its cell. The stand's drawn size goes from 1.6 to 1.3 cells
  (0.1.1, in `Stand.xml`); the images of this suite that show the stand predate it.
- **Capture 7, the fuse smoke on the stills (`docs/runs/2026-09-25-smoke-4.md`): the owner leaned towards a little thicker, and chose "modestly thicker" on 2026-09-25.**
  Puffs 25 % larger (size 1.5 to 2.25) and one every 4 ticks (`Stand.xml`), still a thread and not a cloud, so that it stays distinct from the launch puff. The smoke-4 images predate it: the first gallery run (`docs/runs/`, feature 14) is the next
  picture of it, and her validation of the smoke stays open until she has seen that one.
