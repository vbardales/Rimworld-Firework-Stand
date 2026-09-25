# Documentation read by the Firework Stand session

What was read, in which version, so that a later session knows whether the rules have moved since. A version is the
repository's `HEAD`, the last commit that touched the file, and the blob hash of the file (`git hash-object`, first 12
characters). **"Blob read"** is the file as it was when read; **"Blob now"** is the file at the head listed below. When they
differ, the file moved after it was read, and the last column says what changed (the change was read as a diff, not the whole
file again).

Read on **2026-09-25**; versions refreshed the same day after the protocol documents changed home.

## Where the protocols live now

The protocol documents left the monorepo at commit `90d51374` (2026-09-25 15:25): they belong to the **protocols
repository**, `vbardales/Rimworld-protocols` (`https://github.com/vbardales/Rimworld-protocols.git`), whose git directory is
`C:\Users\nelim\Documents\rimworld-protocols.git` and whose work tree is the monorepo folder itself. They are untracked in the
monorepo and the files stay where they were. Commands on them go through
`git --git-dir=../rimworld-protocols.git --work-tree=. <command>` from the monorepo root. Heads at the time of the refresh:

| Repository | Head |
| --- | --- |
| protocols (`Rimworld-protocols`) | **16f3c59** (was 7546e86 at the refresh) |
| monorepo (`Documents\rimworld`) | 99d91bba |
| `PickleTools` | 2e68653 |
| `Rimworld-Release-Admin` | f196148 (was 2ce34a3) |
| this mod | see `git log` (this file is committed in it) |

## Rules and protocols (protocols repository)

| Document | Lines now | Last commit | Blob read | Blob now | Read, and what changed since |
| --- | --- | --- | --- | --- | --- |
| `AGENTS.md` | 46 | 3a1d2cb, 2026-09-24 | `bb4c08c1e41a` | `bb4c08c1e41a` | in full; unchanged |
| `AUDIT.md` | 232 | 7546e86, 2026-09-25 | `78c72fd1d1d8` | `d1368fb9340f` | in full; since then (read as a diff) two changes: my rule that a failed 32 px legibility check of the delivered ModIcon is reported and put to the owner, who decides whether to override (transition 2); and, written by **another session** at the owner's request and **swept into the same commit by mine**, an exception for `PickleTools/SoundCapture`: those tests play alone, on the Windows install, only on the owner's explicit request, with their own launcher, under the lock |
| `PUBLISHING.md` | 715 | 16f3c59, 2026-09-25 | `595db194bd47` | `b09f556bfaa8` | in full; since then, read as a diff: a paragraph written twice dropped; **the Steam description has one Markdown source** (a fenced block under `## Steam description` of `PUBLICATION.md`, the CI generates the BBCode and the plain `About.xml` description from it, the last line `[Source code on GitHub](URL)`; owner's decision, adopted at the next publication and not forced); **a Steam change note starts with its version** (`[b]1.3.0[/b]`); `dispatch-publish.sh` also refuses without the environment, its reviewer and both secret names; the two CI paths and what each reads; secrets copied by the owner alone with `steam-secrets-codespace.sh` |
| `TRANSLATIONS.md` | 100 | b83933b, 2026-09-23 | `8970fe6c4aab` | `8970fe6c4aab` | in full; unchanged |
| `MOD_SETTINGS.md` | 107 | b83933b, 2026-09-23 | `a61cd541925d` | `a61cd541925d` | in full; unchanged |
| `STYLE_RIMWORLD.md` | 484 | 7311308, 2026-09-25 | `a23c0cea817b` | `83c8a1412d89` | in full; since then **my own edit** (`7311308`, pushed): the ModIcon generation prompt and the mascot description removed, a section "ModIcon : contrôle, pas génération" added, with the rule that a failed 32 px legibility test goes to the owner, who decides whether to override |
| `EXTERNAL_TOOLS.md` | 137 | 28069db, 2026-09-25 | `8620b7a0e1c3` | `8d0facf30c7d` | in full; since then an entry for the "Just Start" mod (not adopted, not useful for our tests: random site and colonists are not reproducible) |
| `scripts/PICKLE-WSL.md` | 7 | 242f65a, 2026-09-23 | `0ff2103b0b0f` | `0ff2103b0b0f` | in full (a pointer to `PickleTools/Headless/README.md`); unchanged |
| `scripts/SEARCHING.md` | 168 | 372c447, 2026-09-23 | `93d971dc6a65` | `93d971dc6a65` | in full; unchanged |
| `scripts/Tests/README.md` | 78 | 486a1f2, 2026-09-25 | `b1ab7077964f` | `a8a311a9a3a9` | in full; since then `stop-game-wsl.sh` no longer ends with a global `pkill -f xvfb-run` (it stops only the `xvfb-run` ancestor of the game it was asked to stop) and its suite has a fourth case |

## Pickle tooling, CI and the backlog

| Document | Lines now | Version | Blob read | Blob now | Read, and what changed since |
| --- | --- | --- | --- | --- | --- |
| `PickleTools/README.md` | 83 | 2e68653 | `5f7e924522de` | `1956429538c9` | in full; since then the wording of the payload: `Mod/` is now the committed Workshop payload with fourteen step DLLs, synced by `Release/Prepare-Release.ps1 -SyncMod` |
| `PickleTools/Headless/README.md` | 487 | 2e68653 | `0a9d177ded1b` | `9e4bf0ba9028` | in full; since then (read as a diff) the request route through `Submit-PickleRun.ps1` is written in, **exit code 3 also covers a game killed by Pickle's own watchdog inside a scenario** (`pickle: watchdog tripped after 120s`), a code 99 (the request worker's, "launcher threw"), the TicketDispatcher's rule on a dead holder, and the game's stderr is printed in the run log |
| `PickleTools/Upstream/PENDING.md` | 47 | 2e68653 | `417c160c9ce4` | `417c160c9ce4` | in full; unchanged |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | 246+ | f196148 | `70c5fba3d1e7` | `70316daa3abf` | in full; since then, read as a diff: "Changing where the Steam description comes from, in both directions" (the one Markdown source, `--description-markdown PUBLICATION.md --description-heading '^## Steam description$' --about-from-description`, the `sync-about-description.mjs` check, compare the text and not the hash), "Two things that catch a mod the day it moves to the CI", and the one-command secrets procedure (`steam-secrets-codespace.sh <owner/repo>`, run by the owner) |
| Pickle `Docs/steps.md` | 577 | **tag v4.9.1** of `RimWorks/Rimworld-Pickle` (the release in use) | `0a868879f4fa` | (fixed by the tag) | in full. Not on this machine: fetched from GitHub. The file on `main` is another blob (`2de0dc179463`, 602 lines: it adds a "World camera" section); the tag's copy is the one read |
| `BACKLOG.md` (monorepo) | 1510 | 99d91bba | `f5b28a5b0698` | `f5b28a5b0698` | **partly**: lines 1 to 150, 273 to 326 and 1435 to 1510, plus the 20 headings. None concerns this mod; the rest is other mods' ideas, not read |

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

## Which of these to read next time

For a mod at this point of the chain, the useful set is `AGENTS.md`, `AUDIT.md`, `PUBLISHING.md`, `OPERATIONS.md`, Pickle's
`steps.md` and the mod's own documents. The others are consulted when a subject calls for them: `STYLE_RIMWORLD.md` for a
Preview or a ModIcon check, `scripts/SEARCHING.md` for a corpus search, `PickleTools/Headless/README.md` for a launcher or
filter question, `EXTERNAL_TOOLS.md` for a tool decision, `BACKLOG.md` never for a mod that is not in it. (Owner's question of
2026-09-25: which of these files were useless to read.)

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
   17 seconds of menu and loading, which is what makes the smoke film useless for the fuse.
8. **The watchdog.** `Headless/README.md` now says exit code 3 also covers a game killed by Pickle's own watchdog inside a
   scenario, and `Authoring/README.md` (not read) has `-pickle-scenario-timeout`. That is very probably what stopped the
   first 0.1.1 English pass at the save-and-reload scenario (`docs/runs/2026-09-24-english-hang.md`, still unexplained
   there): to be checked against that run's log before the note is closed.
9. **Documents of this mod that have drifted** (found while reading, to correct): `TESTING.md` still opens with "Nothing in
   this mod has ever been observed running" and scenario 5 says a smoke failure "does not block publishing";
   `Tests/Pickle/README.md` has its "Why the pass without Ideology plays one feature" section twice, and its Status says
   none of the reshaped suite was played; `README.md` says "nine scenarios"; `PUBLICATION.md` is dated 2026-09-23.
