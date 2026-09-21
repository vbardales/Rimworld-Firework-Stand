# TESTING.md scenario 7: fuel, and what the inspect line says. The mod departs from the usual
# refuelable setup on purpose: fuelConsumptionRate is zero, so nothing drains while idle, and the
# comp removes one rocket per salvo instead. The count is read off vanilla's CompRefuelable.
#
# THE KNOWN ROUGH EDGE IS ON THE CAPTURE ON PURPOSE. The inspect line reports the reload interval
# and not the fuel, so on an empty rack it can read "ready to fire" while the gauge beside it says
# nothing is loaded. STATUS.md records that as a defect and TESTING.md as not a blocker; the capture
# below shows both lines side by side, so a person can see whether it still reads that way, in each
# language. It asserts nothing about the wording.
@review
Feature: one launcher per salvo, nothing drained while idle, and an empty stand stops firing

  Background:
    Given the save "test-colony" is loaded

  Scenario: a loaded stand nobody watches keeps every launcher
    Given a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 5 launchers
    And game speed is ultrafast
    When I wait 1500 ticks
    Then Firework Stand: the stand at x=140 z=150 holds 5 launchers
    And no errors were logged

  @timeout:300
  Scenario: the last launcher is spent, and the empty stand fires no more
    Given a colonist "Watcher" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 1 launchers
    And Firework Stand: "Watcher" is bored
    And game speed is ultrafast
    When Firework Stand: "Watcher" is ordered to watch the stand at x=140 z=150
    Then Firework Stand: the stand at x=140 z=150 comes to hold 0 launchers within 120 seconds
    # Well past the next interval of 900 ticks, with the watcher still there: nothing more to spend,
    # so nothing more may happen, and the light must have gone out.
    When I wait 1200 ticks
    Then Firework Stand: the stand at x=140 z=150 holds 0 launchers
    And Firework Stand: the light of the stand at x=140 z=150 is off
    When I move the camera to (140, 150)
    And Firework Stand: I select the stand at x=140 z=150
    And I wait 30 ticks
    Then I take a screenshot "the empty stand: its inspect line beside its gauge"
    And no errors were logged
