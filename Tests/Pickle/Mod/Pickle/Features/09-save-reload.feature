# TESTING.md scenario 8: save and reload mid-cycle, four scribed fields. The save is taken while the
# light is ON, which is the moment with the most state in flight, and three things are asserted
# after the reload:
#
#   the reload timer survived   the count of launchers does not fall for 300 ticks with the watcher
#                               still there. A timer that was not scribed comes back at "long ago"
#                               and the stand fires again at once, spending a launcher.
#   the light is not stuck on   it goes off by itself. A light flag that came back true with no
#                               deadline would glow for ever.
#   no error on load            nothing about a missing comp.
#
# The stand and the pawn are looked up again by name and by cell at every step, so nothing here
# holds a reference across the reload.
@review
Feature: a stand saved in the middle of a salvo comes back in the same state

  Background:
    Given the save "test-colony" is loaded

  @film @timeout:400
  Scenario: the timer, the light and the count survive a save and a reload
    Given a colonist "Watcher" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 3 launchers
    And Firework Stand: "Watcher" is bored
    And I set the weather to "Clear"
    And I set the hour to 23
    And game speed is ultrafast
    When I move the camera to (140, 150)
    And Firework Stand: "Watcher" is ordered to watch the stand at x=140 z=150
    Then Firework Stand: the light of the stand at x=140 z=150 comes on within 90 seconds
    And Firework Stand: the stand at x=140 z=150 holds 2 launchers
    And the save round trips
    When I save and reload
    Then a "FS_FireworkStand" is at (140, 150)
    And Firework Stand: the stand at x=140 z=150 holds 2 launchers
    When I move the camera to (140, 150)
    And I wait 30 ticks
    And Firework Stand: the light of the stand at x=140 z=150 goes off within 60 seconds
    When I wait 300 ticks
    Then Firework Stand: the stand at x=140 z=150 holds 2 launchers
    And no errors were logged
    And no warning matching "Firework Stand]" was logged
