# TESTING.md translation checks, the part a Pickle step can read. Only true in a French game, so the
# whole feature is `@wip` and skipped by a default (English) pass. The language is chosen when the
# game starts, never during a run, so this is a second pass and not a switch inside one:
# `-Language French -Filter '04-french-names.feature' -IncludeWip`.
#
# Why a running game is needed for it: the French texts reach the defs by DefInjected paths, some of
# them onto defs a patch created a moment before, and the launcher's label is injected onto a
# dependency's def. Whether the paths resolved is the language pipeline's answer, not the file's.
# In developer mode, which every Pickle run is, a missing French key shows as accented gibberish
# rather than English, and these comparisons would fail on it.
#
# Not asserted: the descriptions (they carry literal paragraph breaks), the fuel label and the
# out-of-fuel message (nested comp fields no step reads), the inspect line and the job report.
# Those are read by a person, in game.
@wip
Feature: French names on the stand and the reused launcher

  Scenario: the stand and its recreation type are French
    Then def "FS_FireworkStand" field "label" is "rampe de feux d'artifice"
    And def "FS_Fireworks" field "label" is "feux d'artifice"

  Scenario: the dependency's launcher, translated by this mod, is French
    Then def "FireworkLauncher" field "label" is "lanceur de feux d'artifice"
