# TESTING.md scenario 9: only those who could see it get the memory. This is the one scenario where
# the correct result is that NOTHING happens, so it asserts on both sides: who got the memory, and
# who did not, and it stages all three cases at once so the difference is visible on one screen.
#
# The three filters are: awake, under open sky, capable of sight. Within twenty cells. There is
# deliberately no ground line-of-sight test (the burst is in the air), which is not asserted here
# because it would need a wall and a pawn behind it; it stays a line in TESTING.md.
#
#   Outdoors   awake, under open sky, near the stand           -> has the memory
#   Sleeper    asleep in a bed under a roof, within 12 cells   -> has none
#   Indoors    awake, standing under a roof, within 12 cells   -> has none
#
# Every subject is held where it is (the real Wait job, and the real LayDown job with forceSleep for
# the sleeper) and asserted to be in the state it is meant to be in BEFORE the salvo, so a subject
# that wandered off cannot make the result look right. The watcher is a fourth colonist who really
# walks over and sets the salvo off, as in play. The roof is a constructed roof over a rectangle
# the scenario chooses; the cells are open ground, so this does not test rooms.
#
# The memory is one of four outcomes rolled at random, so the assertion is "one of the four
# fireworks memories", not a particular one.
@review
Feature: the memory of the show goes only to those who could see it

  Background:
    Given the save "test-colony" is loaded

  @timeout:500
  Scenario: the colonist outdoors gains it, the sleeper and the one under a roof do not
    Given a colonist "Watcher" exists
    And a colonist "Outdoors" exists
    And a colonist "Sleeper" exists
    And a colonist "Indoors" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 1 launchers
    And Firework Stand: the cells from x=146 z=153 to x=150 z=157 are roofed
    And Firework Stand: a bed stands at x=147 z=154
    And Firework Stand: "Outdoors" is placed at x=143 z=148
    And Firework Stand: "Indoors" is placed at x=149 z=156
    And Firework Stand: "Sleeper" is placed at x=147 z=155
    And "Sleeper" needs "Rest" is set to 5 percent
    And game speed is ultrafast
    When Firework Stand: "Outdoors" is told to stay where they stand
    And Firework Stand: "Indoors" is told to stay where they stand
    And Firework Stand: "Sleeper" is ordered to sleep in the bed at x=147 z=154
    Then Firework Stand: "Sleeper" is asleep
    # Nobody has seen anything yet: the control that makes "has none" below mean something.
    And Firework Stand: "Outdoors" has no fireworks memory
    And Firework Stand: "Sleeper" has no fireworks memory
    And Firework Stand: "Indoors" has no fireworks memory
    When I move the camera to (145, 152)
    And Firework Stand: "Watcher" is bored
    And Firework Stand: "Watcher" is ordered to watch the stand at x=140 z=150
    Then Firework Stand: the stand at x=140 z=150 comes to hold 0 launchers within 120 seconds
    When I wait 30 ticks
    Then Firework Stand: "Outdoors" has a fireworks memory
    And Firework Stand: "Sleeper" has no fireworks memory
    And Firework Stand: "Indoors" has no fireworks memory
    And I take a screenshot "the stand, the colonist outdoors, the roofed patch with the sleeper and the colonist under it"
    And no errors were logged
