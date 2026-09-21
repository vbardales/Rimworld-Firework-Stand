# TESTING.md scenarios 1 and 2. What the outside-the-game suite cannot show is the game's own load:
# the guarded patch either matched FireworkLauncher in the real patch pipeline or it did not, and a
# def that exists afterwards is the proof that it did. Nothing below needs a colony except the last
# scenario, which loads the fixture save.
#
# The negative half of scenario 2 (Fireworks absent, the mod loads in silence) is not here: Fireworks
# is a hard dependency, so the game refuses to load this mod without it and there is nothing to
# play. It stays a manual check in TESTING.md.
#
# No label is asserted here: this suite runs unchanged in English and in French, and what the
# player reads is looked at on the captures of 11-inspect-pane.feature in both languages.
Feature: Firework Stand loads after Fireworks and its guarded patch matches

  Scenario: the mod is active and loads after Fireworks
    Then mod "nelim.fireworkstand" is loaded
    And mod "telardo.Fireworks" is loaded
    And mod "nelim.fireworkstand" loads after "telardo.Fireworks"

  # FS_WatchFireworks names both the JobDef and the JoyGiverDef, so both are named by type.
  Scenario: the guarded patch added the stand, the recreation type, the job and the joy giver
    Then def "FS_FireworkStand" of type "ThingDef" exists
    And def "FS_Fireworks" of type "JoyKindDef" exists
    And def "FS_WatchFireworks" of type "JobDef" exists
    And def "FS_WatchFireworks" of type "JoyGiverDef" exists

  Scenario: the stand is tied to its own recreation type
    Then def "FS_FireworkStand" field "building.joyKind.defName" is "FS_Fireworks"

  Scenario: loading a game with the mod raises no error and no warning of its own
    Given the save "test-colony" is loaded
    Then no errors were logged
    And no warning matching "Firework Stand]" was logged
