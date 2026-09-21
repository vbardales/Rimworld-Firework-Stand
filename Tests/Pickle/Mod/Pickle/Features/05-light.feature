# TESTING.md scenario 4: the light comes on, and goes off again. This is the failure a player would
# notice first, and it rests on one assumption about the game: CompGlower.ShouldBeLitNow asks every
# comp on the building that implements IThingGlower, and gives up when one says no.
#
# Read off vanilla's own CompGlower.Glows, the flag the light grid is driven by, so the assertion is
# about the light and not about the mod's own bookkeeping. It is asserted at three moments, because
# a light that is off is only meaningful next to one that was on:
#   before   the loaded, idle stand throws no light at all (a permanent glow means the veto is not
#            being consulted, and nothing else in the mod depends on it)
#   during   it comes on when the rocket leaves
#   after    it goes dark again
#
# At night, because the picture is the point: a glow at noon shows nothing. The hour and the weather
# are set by Pickle's own steps and cost nothing.
#
# THE FILM IS THE EVIDENCE. The assertions say the flag flipped; only the film shows warm light
# thrown across the ground for about four seconds, and that is what a person is asked to look at.
@review
Feature: the light comes on for the length of a salvo

  Background:
    Given the save "test-colony" is loaded

  @film @timeout:300
  Scenario: dark, then warm for a few seconds as the rocket leaves, then dark again
    Given a colonist "Watcher" exists
    And a "FS_FireworkStand" is built at (140, 150)
    And Firework Stand: the stand at x=140 z=150 is loaded with 2 launchers
    And Firework Stand: "Watcher" is bored
    And I set the weather to "Clear"
    And I set the hour to 23
    And game speed is fast
    When I zoom all the way in
    And I move the camera to (140, 150)
    And I wait 60 ticks
    Then Firework Stand: the light of the stand at x=140 z=150 is off
    And I take a screenshot "before the salvo: the loaded stand is dark"
    When Firework Stand: "Watcher" is ordered to watch the stand at x=140 z=150
    Then Firework Stand: the light of the stand at x=140 z=150 comes on within 90 seconds
    And I take a screenshot "the rocket has left: the ground is lit"
    And Firework Stand: the light of the stand at x=140 z=150 goes off within 60 seconds
    And I take a screenshot "after the salvo: dark again"
    And Firework Stand: the stand at x=140 z=150 holds 1 launchers
    And no errors were logged
