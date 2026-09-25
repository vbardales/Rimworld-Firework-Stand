# Documentation read by the Firework Stand session

What was read, in which version, so that a later session knows whether the rules have moved since. A version is the
repository's `HEAD` when it was read, the last commit that touched the file, and the blob hash of the file as read
(`git hash-object`, first 12 characters): when the file's blob differs from the one below, it has changed since.

Read on **2026-09-25**. Repositories at the time: monorepo (`C:\Users\nelim\Documents\rimworld`) `HEAD` **a32c50f5**,
`PickleTools` **f499e58**, `Rimworld-Release-Admin` **2ce34a3**, this mod **2cae790**.

## Rules and protocols (monorepo root)

| Document | Lines | Last commit | Blob | Read |
| --- | --- | --- | --- | --- |
| `AGENTS.md` | 46 | 8ce2aeeb, 2026-09-24 | `bb4c08c1e41a` | in full |
| `AUDIT.md` | 227 | a32c50f5, 2026-09-25 | `78c72fd1d1d8` | in full. Its edits were uncommitted when first read and committed since; the blob is the same |
| `PUBLISHING.md` | 685 | 48a19e4b, 2026-09-25 | `595db194bd47` | in full |
| `TRANSLATIONS.md` | 100 | 2e563481, 2026-09-23 | `8970fe6c4aab` | in full |
| `MOD_SETTINGS.md` | 107 | 2e563481, 2026-09-23 | `a61cd541925d` | in full |
| `STYLE_RIMWORLD.md` | 502 | 2e563481, 2026-09-23 | `a23c0cea817b` | in full |
| `EXTERNAL_TOOLS.md` | 124 | 3c78b2e7, 2026-09-24 | `8620b7a0e1c3` | in full |
| `scripts/PICKLE-WSL.md` | 7 | 8c1c0fb1, 2026-09-21 | `0ff2103b0b0f` | in full (a pointer to `PickleTools/Headless/README.md`) |
| `scripts/SEARCHING.md` | 168 | 9a52ea1b, 2026-09-17 | `93d971dc6a65` | in full |
| `scripts/Tests/README.md` | 76 | a32c50f5, 2026-09-25 | `b1ab7077964f` | in full |
| `BACKLOG.md` | 1510 | 19326711, 2026-09-25 | `f5b28a5b0698` | **partly**: lines 1 to 150, 273 to 326 and 1435 to 1510, plus the 20 headings. None concerns this mod; the rest is other mods' ideas, not read |

## Pickle tooling and CI

| Document | Lines | Version | Blob | Read |
| --- | --- | --- | --- | --- |
| `PickleTools/README.md` | 82 | f499e58, 2026-09-25 | `5f7e924522de` | in full |
| `PickleTools/Headless/README.md` | 466 | 2da3bb5, 2026-09-24 | `0a9d177ded1b` | in full |
| `PickleTools/Upstream/PENDING.md` | 47 | f4c43d4, 2026-09-25 | `417c160c9ce4` | in full |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | 207 | 2ce34a3, 2026-09-25 | `70c5fba3d1e7` | in full |
| Pickle `Docs/steps.md` | 577 | **tag v4.9.1** of `RimWorks/Rimworld-Pickle` (the release in use), blob `0a868879f4fa` | | in full. It is not on this machine: fetched from GitHub. The file on `main` is a different blob (`2de0dc179463`, 602 lines: it adds a "World camera" section), so the tag's copy is the one read |

Also read earlier in this session: `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` (53 lines, sent by the dispatcher).

## This mod

| Document | Lines | Last commit | Blob | Read |
| --- | --- | --- | --- | --- |
| `STATUS.md` | 640 | fe2dab4 | `544fb13e62a8` | in full (it is this session's own record) |
| `README.md` | 78 | d51b7dd | `483457ef7475` | in full |
| `CHANGELOG.md` | 66 | d51b7dd | `667b93a93e0e` | in full |
| `ATTRIBUTION.md` | 56 | c3d3a6f | `4ccdb29d9a1f` | in full |
| `LICENSE` | 21 | 84e7230 | `5b587b292146` | first lines only: MIT, copyright 2026 Nelim |
| `PUBLICATION.md` | 84 | 4383f56 | `9d25b52edfc4` | in full |
| `TESTING.md` | 262 | d51b7dd | `23884a7c8284` | in full |
| `Mod/About/About.xml` | 51 | 2413f50 | `25b3432d5bf4` | in full |
| `Tests/Pickle/README.md` | 187 | 6c81af6 | `3670c6845742` | in full |
| `docs/runs/` | 12 files | | | index and the summaries written in this session; the older ones are this session's own |
| `NOTES.md`, `BUGS.md` | | | | **do not exist in this repository** |

## What the reading found, that this mod has to act on

New in the protocols since the last read, or not yet applied here. None of it is done yet.

1. **Publication has no workflow in the mod.** `PUBLISHING.md` and `OPERATIONS.md` describe the generator
   `Rimworld-Release-Admin/scripts/generate-publish-workflow.sh <mod-repo> --workshop-id 3806767445 --package-id
   nelim.fireworkstand --release-title "Firework Stand {version}" --require Assemblies --require Defs
   --description-file PUBLICATION.md ...`, then a dry-run of the exact SHA, `dispatch-publish.sh`, and only the owner
   approves `steam-production`. Options `update_preview`, `update_description`, `update_title`, `update_tags` are off by
   default. The description on the page is the 0.1.0 one; a publish with `update_description` would replace it.
2. **The CI reads `CHANGELOG.md` as `## [<version>]`, dated**, and the Steam change note from a `### <version>` block of
   `PUBLICATION.md`. Here the headings are `# 0.1.1` and `# 0.1.0` and there is no block. `AUDIT.md` itself writes
   `## [0.1.0]`.
3. **Gallery folder rule (2026-09-25).** A folder holding only the images to upload, numbered `01-`, `02-`, ..., nothing
   else, also the `--gallery-dir` of the workflow. The Workshop gallery stays manual. Raw captures live elsewhere,
   ignored by git. `PUBLICATION.md`'s capture plan is older than this and points at a run folder that no longer exists.
4. **Showcase captures are a scenario of their own** (`AUDIT.md`, "Captures destinées à la publication"; `PickleTools`
   `ScreenshotStudio`, fixture `nelim-zen-meadow-studio`, staged with ClearScreen through `wsl-deps.studio.map`): the scene
   is mounted by the scenario, no dev tools, no other mod's overlay, no film corner frame, no corpse. The stills of the
   test colony show a skeleton beside the stand: that is the reason.
5. **THANKS names the tools really used.** `About.xml` credits Claude Code and DALL-E, and telardo. `PUBLISHING.md`
   also asks for Pickle and, when a pass stages one of its tools, `PickleTools` (private item `3806142401`), stated as
   development-only and never a dependency. This mod stages neither PickleTools nor ClearScreen yet; if the showcase
   scenario does, it must be credited. The Steam thank-you comment for telardo is a per-recipient draft, to be checked
   against `WORKSHOP_COMMENTS.md` (not read: it is not among the documents listed) before posting.
6. **Fail fast** (`AUDIT.md`, `PUBLISHING.md`, 2026-09-25): publish once no red is open, then the regression pass runs.
   Not waived: every red scenario replayed green on a build with its fix (the smoke scenario is still to be replayed
   and looked at), the gallery, the owner's manual validations, the pipeline guards, and a rollback target chosen
   beforehand (a tag at every good version).
7. **Pickle flag worth using:** `-pickle-max-film-seconds` (`EXTERNAL_TOOLS.md`), and `@film` scenarios open with about
   17 to 25 seconds of menu and loading, which is what makes the smoke film useless for the fuse.
8. **Documents of this mod that have drifted** (found while reading, to correct): `TESTING.md` still opens with "Nothing in
   this mod has ever been observed running" and scenario 5 says a smoke failure "does not block publishing";
   `Tests/Pickle/README.md` has its "Why the pass without Ideology plays one feature" section twice, and its Status says
   none of the reshaped suite was played; `README.md` says "nine scenarios"; `PUBLICATION.md` is dated 2026-09-23.
