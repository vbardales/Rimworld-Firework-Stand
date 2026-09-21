# The English and French display check of TESTING.md, the part that is a picture. No step spells a
# translated word: the stand is selected by where it stands, so the same feature runs in the
# language the pass was staged with, and the two passes differ only in what the captures show.
#
# What a person looks for, in each language: a raw key such as FireworkStand.Reloading, French text
# falling back to English (in developer mode, which every Pickle run is, a missing key shows as
# accented gibberish rather than clean English, so both are visible), broken accents, a clipped
# line, the fuel gauge's label, the description's paragraph break, the formatted time in the
# "reloading" line.
#
# Two states of the same stand, because the inspect line differs between them: a stand that has just
# fired (counting down its reload) and one that has never fired. Then the blueprint, placed through
# the game's own designator, which draws the watching area around it. Nothing asserts a word.
@review
Feature: what the player reads about the stand, in the language of the pass

  Background:
    Given the save "test-colony" is loaded

  @timeout:300
  Scenario: the stand loaded and waiting, then reloading after a salvo
    Given a colonist "Watcher" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 4 launchers
    And Firework Stand: "Watcher" is bored
    And game speed is ultrafast
    When I zoom all the way in
    And I move the camera to (140, 150)
    And Firework Stand: I select the stand at x=140 z=150
    And I wait 30 ticks
    Then Firework Stand: the stand at x=140 z=150 holds 4 launchers
    And I take a screenshot "the loaded stand, never fired"
    When Firework Stand: "Watcher" is ordered to watch the stand at x=140 z=150
    Then Firework Stand: the stand at x=140 z=150 comes to hold 3 launchers within 120 seconds
    When Firework Stand: I select the stand at x=140 z=150
    And I wait 60 ticks
    Then I take a screenshot "the same stand counting down its reload"
    And no errors were logged

  Scenario: the blueprint, placed through the designator, with its watching area
    Given research "IEDs" is finished
    And 60 "Steel" is spawned at the stockpile
    And 30 "WoodLog" is spawned at the stockpile
    When I use the build designator for "FS_FireworkStand" at (140, 150)
    And I zoom all the way in
    And I move the camera to (140, 150)
    And I wait 30 ticks
    Then a blueprint for "FS_FireworkStand" is at (140, 150)
    And I take a screenshot "the blueprint of the firework stand"
    And no errors were logged
