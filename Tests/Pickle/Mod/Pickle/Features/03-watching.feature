# TESTING.md scenario 6: a colonist goes to the stand on their own, as recreation. This is the one
# thing in the mod that only a running colony can show, and the scenario below is a HYPOTHESIS, not
# a result: it has never been played, and it rests on two guesses the vanilla steps cannot settle.
#
#   1. The stand is empty here (no step loads a refuelable). Whether JoyGiver_WatchBuilding offers
#      an empty building depends on the vanilla check, which was not read for this scenario; the
#      stand only refuses to FIRE without fuel.
#   2. Two thousand ticks may be too few or too many for a colonist to pick recreation, so a red
#      here is not yet a defect of the mod.
#
# Hence `@wip`: a default run skips it, and it is played on purpose with
# `-Filter '03-watching.feature' -IncludeWip` and its outcome read by a person. The stand distance,
# the standing posture and the roofed-stand refusal are not asserted by any step and stay manual.
@wip
Feature: a colonist walks to the stand on their own

  Background:
    Given the save "test-colony" is loaded
    And game speed is ultrafast

  Scenario: an idle colonist with a low recreation need watches the stand
    Given a colonist "Walker" exists
    And a "FS_FireworkStand" is built at (140, 150)
    When "Walker" needs "Joy" is set to 5 percent
    And I wait 2000 ticks
    Then "Walker" has job "FS_WatchFireworks"
