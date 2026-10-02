# Documentation read by the Firework Stand session

What was read, in which version, so that a later session knows whether the rules have moved since and which documents
are worth opening again. A version is the blob hash of the file (`git hash-object`, first 12 characters) and the last
commit that touched it. When the hash now differs from the one below, read the diff (`git diff <commit>..HEAD -- <file>` in
the protocols repository), not the whole file.

Refreshed on **2026-10-02** (audit of `STATUS.md`, owner's request). The first reading was on 2026-09-25; the table of that
day is replaced here, its useful conclusions are in "What the reading found".

## Heads at the time of this refresh

| Repository | Head |
| --- | --- |
| protocols (`Rimworld-protocols`, git dir `../rimworld-protocols.git`, work tree = the monorepo folder) | 4e8f11a |
| monorepo (`Documents\rimworld`) | c770fd1e |
| `PickleTools` | b7620cb |
| `Rimworld-Release-Admin` | d5282af |
| `Rimworld-Ticket-Dispatcher` | dcbecf7 |
| this mod | see `git log` |

## Rules and protocols (protocols repository)

"How" says what this session really did on 2026-10-02: **full** = read start to end; **diff** = the 2026-09-25 version had
been read in full and only the changes since were read; **hash** = nothing read, only the hash recorded, because no subject of
the audit called for it.

| Document | Lines | Blob | Last commit | How | Useful for this mod? |
| --- | --- | --- | --- | --- | --- |
| `AGENTS.md` | 21 | `44dddcbc8ff6` | 7fd7475, 2026-09-29 | full (it is in the session's instructions) | yes: evidence rules, CI publishing guards |
| `AUDIT.md` | 276 | `daab030ccf54` | d1fdbe1, 2026-10-02 | full | yes: the audit itself. Moved since 2026-09-25: Pickle order (never-run and red first, non-regression last), gates of `done -> tested` (no `@wip`, conditional scenarios run, no manual test), the 1.0.0 comes with `published`, cleanup of `STATUS.md`/WSL/branches after publication, session title format |
| `PUBLISHING.md` | 789 | `11de03424fd5` | 4e8f11a, 2026-10-02 | diff since 16f3c59 | yes: gallery folder is `0-preview` then `1-`, `2-` (one digit), PR to the original repository when one exists, workshop comment rules, CI paths |
| `TRANSLATIONS.md` | 216 | `7b4d9a23bd3b` | af8427f, 2026-10-02 | full | yes: plural forms, French agreement (o-series), systematic French review by Virginie, `FRENCH_REVIEW.md` format (mod name first line) |
| `MOD_SETTINGS.md` | 107 | `a61cd541925d` | b83933b, 2026-09-23 | full on 2026-09-25, unchanged | settings are `not_applicable` here; only to reread if the mod ever gets a setting |
| `STYLE_RIMWORLD.md` | 716 | `773961397c34` | c105a43, 2026-10-01 | hash (2026-09-25 version read in full) | only for a Preview or ModIcon check (typography, echo line-art, badge corner): moved a lot, read the Preview sections before touching `Art/` |
| `WORKSHOP_COMMENTS.md` | 159 | `cdd3381ba922` | 7fd7475, 2026-09-29 | hash | not yet: needed when the telardo thank-you is rewritten ("Writing a comment") |
| `EXTERNAL_TOOLS.md` | 138 | `03f73692f122` | 448991f, 2026-09-25 | full on 2026-09-25 | no: a tool decision only |
| `scripts/SEARCHING.md` | 222 | `45f0fa13cc4e` | 50de695, 2026-09-28 | hash | no: corpus search, nothing to search here |

## Pickle tooling, CI and tickets

| Document | Lines | Blob | How | Useful for this mod? |
| --- | --- | --- | --- | --- |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | 112 | `347a0d63b9f6` | full | yes: dry-run of the exact SHA, `publish` takes the 40-character SHA, `### <version>` fenced block for the Steam note, `## [<version>]` in the CHANGELOG, one Markdown description source. The file shrank from 246 lines; history is in git |
| `PickleTools/README.md` | 89 | `1d28b27e6737` | hash (2026-09-25 version read in full) | when a step is needed (this mod uses none of the shared tools) |
| `PickleTools/Headless/README.md` | 509 | `c023a674fbbe` | hash (2026-09-25 version read in full) | only for a launcher question: this session submits no run |
| `PickleTools/docs/steps.md` | 285 | `8639a06971fb` | hash (2026-09-25 read the tag v4.9.1 copy; the folder is now `docs/`) | when a new step is written |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | 150 | `1bdd1eed63a3` | hash | when a ticket is first submitted (it was read once, 2026-09-25) |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | 133 | `7ab5e437d43f` | hash | when a ticket is submitted |
| `BACKLOG.md` (monorepo) | | | not read | no: never for a mod that is not in it. Not this mod's `BACKLOG.md`, which does not exist |

## This mod

| Document | Read on 2026-10-02 | Note |
| --- | --- | --- |
| `STATUS.md` | front matter and the sections touched | long (about 700 lines, older sections are history) |
| `README.md`, `ATTRIBUTION.md`, `LICENSE` | not reread | current states, not touched by the audit |
| `CHANGELOG.md` | full | `## [1.0.0] - unreleased` above `## [0.1.0] - 2026-09-23`; a stray 0.1.1 bullet removed from the 0.1.0 section |
| `PUBLICATION.md` | the gallery, description, change-note and CI sections | change notes are now fenced blocks under `### <version>`, as the CI reads them |
| `TESTING.md` | full | "What proves what today" added |
| `Tests/Pickle/` | listed, `README.md` not reread | |
| `docs/runs/` | the index | evidence lines brought up to date |
| `NOTES.md`, `BUGS.md`, `BACKLOG.md` | do not exist | the PR to the original mod is not due: no repository of the original found (see `STATUS.md`) |

## Which of these to read next time

For a mod at this point of the chain: `AUDIT.md` and `PUBLISHING.md` (diffs only), `OPERATIONS.md` (before the CI), and the
mod's own documents. `TRANSLATIONS.md` when a French or English text changes. The rest on demand, as the "Useful" column says.

## What the reading found, that this mod has to act on

1. **The version that comes with `published` is 1.0.0**, not 0.1.1. Done in the CHANGELOG and the publication sheet.
2. **The Steam change note must be a fenced block under `### <version>`**: it was a blockquote, which the CI would have
   refused (`fencedBlockUnder`). Fixed in `PUBLICATION.md`.
3. **Gallery numbering is `0-`, `1-`, `2-`** (one digit): `_tools/Crop-Gallery.ps1` and the sheet are aligned. The `Gallery/`
   folder does not exist yet; it is built from `2026-09-28-vitrine-11` at the publication.
4. **`FRENCH_REVIEW.md` starts with the mod's name.** The shared `scripts/Make-FrenchReview.ps1` leaves the English column
   empty here (the stand's defs live in `Mod/Patches/Stand.xml`), so the mod keeps `_tools/Generate-FrenchReview.ps1`,
   aligned to the new heading.
5. **Gates for `tested`** are listed in `TESTING.md` ("What proves what today").
