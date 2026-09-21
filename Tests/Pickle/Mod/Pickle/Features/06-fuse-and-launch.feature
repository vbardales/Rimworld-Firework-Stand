# TESTING.md scenario 5: the fuse smoke and the launch effects, which are this mod's own contribution
# rather than telardo's. Nothing can assert smoke: no step reads a fleck, and none should be
# written to. So this is a film and two stills for a person, and it claims nothing else.
#
# What the assertions do is make the footage worth watching: the stand really fired (a launcher was
# spent), so the fuse was lit; and the camera is on the stand, at the closest zoom, before the order
# is given, so the footage of the fuse is not the whole map at default zoom. The stills are timed
# from the moment the launcher is spent: the fuse burns for 60 ticks, then the puff and sparks.
#
# A failure here is cosmetic and does not gate publishing; note it and move on.
@review
Feature: the fuse smokes, then the rocket leaves

  Background:
    Given the save "test-colony" is loaded

  # Filmed with no stills, then the same staging again with the stills and no film: a screenshot taken
  # while a film is recording can be polluted by the film's own 480x270 frame (first run, 2026-09-21).
  @film @timeout:240
  Scenario: filmed: a thread of smoke at the foot of the stand, then a thick puff and sparks
    Given a colonist "Watcher" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 1 launchers
    And Firework Stand: "Watcher" is bored
    And game speed is normal
    When I zoom all the way in
    And I move the camera to (140, 150)
    And Firework Stand: "Watcher" is ordered to watch the stand at x=140 z=150
    Then Firework Stand: the stand at x=140 z=150 comes to hold 0 launchers within 120 seconds
    When I wait 150 ticks
    Then no errors were logged

  @timeout:240
  Scenario: stills: a thread of smoke at the foot of the stand, then a thick puff and sparks
    Given a colonist "Watcher" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 1 launchers
    And Firework Stand: "Watcher" is bored
    And game speed is normal
    When I zoom all the way in
    And I move the camera to (140, 150)
    And Firework Stand: "Watcher" is ordered to watch the stand at x=140 z=150
    Then Firework Stand: the stand at x=140 z=150 comes to hold 0 launchers within 120 seconds
    # The launcher is spent the instant the fuse is lit. Twenty ticks in, the thread of smoke is
    # rising; seventy ticks in, the fuse is done and the puff, the sparks and the flash are out.
    When I wait 20 ticks
    Then I take a screenshot "the fuse smoking at the foot of the stand"
    When I wait 50 ticks
    Then I take a screenshot "the puff and the sparks as the rocket leaves"
    And no errors were logged
