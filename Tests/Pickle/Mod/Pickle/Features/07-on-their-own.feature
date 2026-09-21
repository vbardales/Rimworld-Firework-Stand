# TESTING.md scenario 6: colonists go to the stand on their own, as recreation. The other scenarios
# order the watching job, which proves the driver; this one proves the JoyGiverDef, which is what
# makes it recreation and not an order.
#
# WHAT THE VANILLA GIVER WAS READ TO SAY (JoyGiver_WatchBuilding and JoyGiver_InteractBuilding, read
# from the compiled game on 2026-09-21): it offers a building that can be reserved, is not
# forbidden, is not fogged, is socially proper, is not under vacuum, has power if it has a power
# comp, and, when the def says unroofedOnly, is not under a roof. It never looks at fuel: an EMPTY
# stand is offered too, and watching one earns the colonist full recreation without a rocket going
# up, because the driver's joy tick is vanilla's and does not ask the stand. That is a design
# question rather than something to assert here; see STATUS.md.
#
# WHAT THESE SCENARIOS CANNOT PROMISE. The colonist is bored, alone, and the stand is the only
# recreation building this scenario puts on the map; the fixture colony may have others, and the
# think tree may pick one of them first. A red here reads as "took another recreation", and the
# failure message names the job the colonist did take. The unroofed scenario is the one that says
# the mod works; the roofed one is a control for `unroofedOnly` and passes for the right reason
# only if the first one passes.
@review
Feature: a bored colonist goes to the stand by themselves

  Background:
    Given the save "test-colony" is loaded

  @film @timeout:400
  Scenario: an idle colonist with a low recreation need walks to an open stand and watches it standing
    Given a colonist "Idle" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 2 launchers
    And Firework Stand: "Idle" is bored
    And game speed is ultrafast
    When I move the camera to (140, 150)
    And I wait for "Idle" to have job "FS_WatchFireworks"
    Then Firework Stand: "Idle" is watching the stand at x=140 z=150
    And Firework Stand: "Idle" stands between 4 and 12 cells from the stand at x=140 z=150, with no chair
    When I wait 120 ticks
    Then I take a screenshot "an idle colonist watching, standing, from a distance"
    And no errors were logged

  Scenario: a stand under a roof is never used
    Given a colonist "Idle" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the cells from x=138 z=148 to x=142 z=152 are roofed
    And Firework Stand: the stand at x=140 z=150 is loaded with 2 launchers
    And Firework Stand: "Idle" is bored
    And game speed is ultrafast
    When I wait 600 ticks
    Then Firework Stand: "Idle" does not watch any stand
    When I wait 600 ticks
    Then Firework Stand: "Idle" does not watch any stand
    When I wait 600 ticks
    Then Firework Stand: "Idle" does not watch any stand
    And Firework Stand: the stand at x=140 z=150 holds 2 launchers
