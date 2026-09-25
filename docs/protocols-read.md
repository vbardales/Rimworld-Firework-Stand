# Protocols read by the Firework Stand session

What was read, in which version, so that a later session knows whether the rules have moved since. The version is the
monorepo (`C:\Users\nelim\Documents\rimworld`) commit that was `HEAD` at the time, the last commit that touched each
file, and the blob hash of the file as it was on disk (`git hash-object`, first 12 characters): when the blob differs
from the one below, the document has changed since it was read.

Read on **2026-09-25**, monorepo `HEAD` **48a19e4b** ("docs(publishing): fail fast lifts only the regression pass; a red
scenario needs a green replay before publish"), in full.

| Document | Lines | Last commit that touched it | Blob | Working tree |
| --- | --- | --- | --- | --- |
| `AGENTS.md` | 46 | 8ce2aeeb, 2026-09-24 | `bb4c08c1e41a` | clean |
| `AUDIT.md` | 227 | 48a19e4b, 2026-09-25 | `78c72fd1d1d8` | **modified, not committed**: what was read includes edits that no commit holds yet |
| `MOD_SETTINGS.md` | 107 | 2e563481, 2026-09-23 | `a61cd541925d` | clean |
| `TRANSLATIONS.md` | 100 | 2e563481, 2026-09-23 | `8970fe6c4aab` | clean |
| `PUBLISHING.md` | 685 | 48a19e4b, 2026-09-25 | `595db194bd47` | clean |

Not read in this pass (also at the monorepo root, none is linked by `AGENTS.md` as a gate): `STYLE_RIMWORLD.md`,
`PUBLISHING_STATE.md`, `EXTERNAL_TOOLS.md`, `WORKSHOP_COMMENTS.md`, `SETTINGS_STEAM_DECK.md`, `BACKLOG.md`. Not read either:
the guides under `PickleTools/` (`Authoring`, `Headless`, `Upstream`), which `AUDIT.md` points to for Pickle suites, and
`Rimworld-Release-Admin/docs/OPERATIONS.md`, which `PUBLISHING.md` points to for the CI. The `WELCOME.md` of the
TicketDispatcher was read earlier in this session.

## What each one settles for this mod

- **`AGENTS.md`**: the ordered gates (settings, then translations, then `preTest`), the evidence policy (latest report
  per mod and scenario, one text line per run in `docs/runs/`, never delete a report a `STATUS.md` field points to),
  and publication by CI only.
- **`AUDIT.md`**: the stage chain and the criteria of each transition. For `done -> tested`: scenarios played in game,
  no `@wip`, every conditional scenario played, no manual test left, `@review` captures actually opened, `exitReason`
  read before the counts, at least two passes (without and with the optional mods). Run submission goes through
  `Submit-PickleRun.ps1`, one pass per request, no monitor of our own; a request carries no SHA, so the tree stays on
  the revision under test until `RUN_DONE`. The `0.1.0` prepublication is an act, not a state; `1.0.0` arrives with
  `published`. Fail fast: publish once no red is open, then the regression pass runs; not skipped even then: a red
  scenario replayed green on a build with its fix, the Workshop gallery, the owner's manual validations, the pipeline
  guards, the rollback target chosen beforehand. The session title is `<mod> / <stage>`.
- **`MOD_SETTINGS.md`** and **`TRANSLATIONS.md`**: already satisfied for this mod (`settings_audit: not_applicable`,
  `localization`, `translation_en`, `translation_fr` complete). They reset to `unchecked` if options, UI or player-facing
  text change; the 0.1.1 changes touch no text (the fuse smoke is a def and an effect), so none is reset.
- **`PUBLISHING.md`**: see the gaps listed in the session of 2026-09-25: no publication workflow in the mod yet, the
  CHANGELOG headings are `# 0.1.1` where the CI reads `## [0.1.1]` (`AUDIT.md` also writes `## [0.1.0]`), `PUBLICATION.md`
  has no `### <version>` block for the Steam change note, and its capture plan predates the numbered gallery folder rule
  (2026-09-25).
