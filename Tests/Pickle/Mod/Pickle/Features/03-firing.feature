# TESTING.md scenario 3, and the first half of scenario 6 (where they stand). READ THE TAG BEFORE THE
# COLOUR: @review asserts nothing about an image. The assertions here say what the stand DID, and
# they are made before each capture so that the image is worth opening; what the image looks like
# is for a person.
#
# The single mechanism this mod is built on is the rearming: telardo's comp sets its own `launched`
# field so it fires once, and this mod sets it back before each salvo. A stand that fired one rocket
# and then nothing, with fuel left and a colonist still watching, is the failure. One launcher is
# spent per salvo, so the count of launchers is the count of salvoes, and it is read off vanilla's
# CompRefuelable, not off anything of ours.
#
# A REAL watcher. The colonist is ordered to watch with the mod's own job, on the cell the joy giver
# would choose, and the mod's driver reports to the stand on every tick. Nothing calls the stand
# directly, so a driver graft that no longer binds shows here as a stand that never fires.
#
# No step spells a translated word: the suite runs unchanged in English and in French.
#
# NO STILLS IN A FILMED SCENARIO. The first run (2026-09-21) showed that a screenshot taken while a
# film is recording is polluted: the film's own 480x270 frame lands in the corner of the still. The
# film is the evidence here; the stills that matter are taken in scenarios that are not filmed.
@review
Feature: the stand fires, and fires again

  Background:
    Given the save "test-colony" is loaded

  @film @timeout:300
  Scenario: two salvoes go up from a loaded stand, one launcher each
    Given a colonist "Watcher" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 3 launchers
    And Firework Stand: "Watcher" is bored
    And game speed is ultrafast
    When I move the camera to (140, 150)
    And Firework Stand: "Watcher" is ordered to watch the stand at x=140 z=150
    Then Firework Stand: "Watcher" is watching the stand at x=140 z=150
    And Firework Stand: "Watcher" stands between 4 and 12 cells from the stand at x=140 z=150, with no chair
    # The first salvo leaves as soon as the watcher is in place: the timer starts far in the past.
    And Firework Stand: the stand at x=140 z=150 comes to hold 2 launchers within 90 seconds
    # The second one is 900 ticks later, at the stand's own interval. Two or more is the pass; one
    # rocket and then nothing, fuel still there, is the failure this scenario exists to catch.
    And Firework Stand: the stand at x=140 z=150 comes to hold 1 launchers within 180 seconds
    When I wait 150 ticks
    Then Firework Stand: "Watcher" is watching the stand at x=140 z=150
    And no errors were logged
    And no warning matching "Firework Stand]" was logged
