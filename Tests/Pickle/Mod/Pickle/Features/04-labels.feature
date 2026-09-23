# TESTING.md translation checks, the part a Pickle step can read. This replaces 04-french-names.feature,
# which was tagged `@wip` and only true in a French game. A scenario nobody plays unless asked is not
# tested, so each label is now asserted against the value written here FOR THE LANGUAGE THE PASS RUNS
# IN, by a step that reads the active language: the same scenario is green in the English pass (English
# values) and in the French pass (French values), and it fails, naming the language, in a pass whose
# language it has no value for. Nothing is skipped and nothing passes vacuously.
#
# Why a running game is needed for it: the French texts reach the defs by DefInjected paths, some of
# them onto defs a patch created a moment before, and the launcher's label is injected onto a
# dependency's def. Whether the paths resolved is the language pipeline's answer, not the file's. In
# developer mode, which every Pickle run is, a missing key in the active language shows as accented
# gibberish rather than clean English, so an absent French entry fails the comparison.
#
# Not asserted here: the descriptions (they carry literal paragraph breaks), the fuel label and the
# out-of-fuel message (nested comp fields no step reads), the inspect line and the job report. Those are
# read on the captures of 11-inspect-pane.feature, in each language, by a person.
Feature: the stand and the reused launcher are named in the language of the pass

  Scenario: the stand and its recreation type carry the labels of the language
    Then Firework Stand: the label of the ThingDef "FS_FireworkStand" reads "firework stand" in English and "rampe de feux d'artifice" in French
    And Firework Stand: the label of the JoyKindDef "FS_Fireworks" reads "fireworks" in English and "feux d'artifice" in French

  Scenario: the dependency's launcher, translated by this mod in French, carries the label of the language
    Then Firework Stand: the label of the ThingDef "FireworkLauncher" reads "firework launcher" in English and "lanceur de feux d'artifice" in French
