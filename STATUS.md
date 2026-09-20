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
stage:        done
licence:      open
licence_at:   MIT in LICENSE and Mod/LICENSE for this mod; upstream permission is separate and not established
upstream_permission: silent
upstream_permission_at: No licence file found in the installed Fireworks dependency; no explicit consent or written refusal documented
maintainer:   Codex, responsible for this repository and STATUS.md
dependencies: declared
showcase:     complete
tested_on:
automated_on: 2026-09-13
workshop:
settings_audit: not_applicable
audit_on:     2026-09-13
audit_revision: 8ff9fdaca496e908e42bf0574a970d5a8b13e9f7
remaining:
  - accepted: current Preview including its camera explicitly approved by the user on 2026-09-13; no camera revision required
  - unverified: English/French in-game translation checks in TESTING.md, including dependency absence and launch gizmo with/without Ideology
  - unverified: all nine manual scenarios and English/French UI/log checks remain required for tested; the historical publishing subset does not waive this gate
  - limitation: five existing assembly contract tests have no recorded mutation test; passing outside the game does not establish runtime behaviour
  - defect: inspect line says Ready to fire on an empty rack; the fuel gauge remains accurate
  - accepted: orange-face mod icon deviation accepted on 2026-09-04
session:      local_db219fa5-6fea-40f2-b0fa-aa63c79d3774
updated:      2026-09-13
---

# Firework Stand — status

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

## Title decision — 2026-09-13

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

## Translation audit — 2026-09-13

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

## Preview overlay — 2026-09-13

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

### Preview illustration revision — 2026-09-13

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

## Ordered workflow audit — 2026-09-13

This section supersedes historical global-stage claims without deleting their evidence.
Previous stage: `done`. Retained stage: `modIcon`, meaning **ModIcon generated**
(`ModIcon générée` in the requested workflow). `done` means ready for final game validation;
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

## Preview acceptance — 2026-09-13

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

## Source-link correction — 2026-09-13

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
