# TESTING.md scenarios 2 (the bridge resolves) and 8 (save and reload), the parts a Pickle step can
# reach. A stand is put on the map and left to run; the log is the assertion. FireworksBridge
# reaches into Fireworks by reflection, and a renamed class or field there shows only as a
# `[Firework Stand]` warning the first time the bridge is asked. The bridge is asked lazily, so
# only the last scenario of this file (the stand selected, its inspect line read) makes it happen;
# in the first two, "no warning" says nothing about the bridge.
#
# What is NOT asserted, and why. No vanilla step loads a refuelable comp or reads a comp field, so
# the stand stays empty here: the reload timer surviving a save (scenario 8's first bullet), the
# light coming on and going off (4), the smoke (5) and the fuel count (7) stay manual. The save
# round trip does prove the scribe does not fail, and that no comp goes missing on load, which is
# scenario 8's third bullet.
Feature: a stand on the map runs, saves and reloads without a complaint

  Background:
    Given the save "test-colony" is loaded
    And game speed is ultrafast

  Scenario: a stand can be built and left running
    Given a "FS_FireworkStand" is built at (140, 150)
    When I wait 300 ticks
    Then a "FS_FireworkStand" is at (140, 150)
    And no errors were logged
    And no warning matching "Firework Stand]" was logged

  Scenario: a stand survives a save and a reload
    Given a "FS_FireworkStand" is built at (140, 150)
    When I wait 120 ticks
    Then the save round trips
    When I save and reload
    Then a "FS_FireworkStand" is at (140, 150)
    And no errors were logged
    And no warning matching "Firework Stand]" was logged

  # The capture shows what the stand looks like, drawn from Fireworks' launcher texture. Nothing
  # asserts that: a person opens the picture. The texture path itself is checked outside the game
  # by the functional suite.
  @review
  Scenario: the stand as the player sees it, empty
    Given a "FS_FireworkStand" is built at (140, 150)
    When I zoom all the way in
    And I move the camera to (140, 150)
    And I wait 30 ticks
    Then I take a screenshot "firework stand, empty"

  # Added after the first run of this feature, which showed that the two scenarios above cannot
  # stand for scenario 2. FireworksBridge resolves lazily, on the first read of `Available`, and
  # the only readers are Notify_Watched (a colonist watching) and CompInspectStringExtra (the
  # inspect pane). Nothing in the scenarios above does either, so the bridge was probably never
  # asked and "no warning" was vacuous there. Selecting the stand opens the inspect pane, which
  # asks. Selected by where it stands and not by its label, so the scenario runs in either language.
  @review
  Scenario: selecting the stand reads its inspect line, which resolves the bridge
    Given a "FS_FireworkStand" is built at (140, 150)
    When Firework Stand: I select the stand at x=140 z=150
    And I wait 60 ticks
    And no errors were logged
    And no warning matching "Firework Stand]" was logged
    And I take a screenshot "firework stand, selected, with its inspect line"
