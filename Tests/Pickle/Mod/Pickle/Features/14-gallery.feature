# The Workshop gallery (PUBLICATION.md, "Gallery"), produced by a scenario of its own so that it can be replayed after
# any change of the mod. It is not a test of the mod: the functional scenarios of features 01 to 13 are that. What it
# asserts is only what makes an image worth keeping (the stand exists, is loaded, the salvo really happened), and what
# a person opens afterwards is the image.
#
# WHY NOT THE TEST COLONY'S CAPTURES. They show a corpse beside the stand in almost every picture, they were taken
# with the game's interface and, in a filmed scenario, with the film's corner frame. This scene is PickleTools'
# ScreenshotStudio, a paused, dressed meadow saved as the fixture `nelim-zen-meadow-studio`, staged with ClearScreen
# through `wsl-deps.vitrine.map`. Nothing of it belongs to the mod, and nothing of this feature runs without it: it is
# tagged @requires and is played by the pass `vitrine`, and skipped (counted as skipped) by the others.
#
# THE INTERFACE. The game's own screenshot mode (`studio presentation mode is enabled`) hides the HUD for the pictures
# that show the world (01 to 03) and is left off for the two that show the interface (04, 05), which are there to show
# it. ClearScreen keeps a log viewer or a notice of another mod out of every frame.
#
# THE ZOOM. Every picture is taken with the camera all the way in (the owner's rule, 2026-09-26): what a picture has
# to prove must fill at least half the height of the window, and the game cannot zoom further, so the picture is then
# cropped around the subject (PUBLICATION.md, "Gallery"). The camera is set a few cells north of the stand for the
# pictures that hold the rocket and its burst, which rise above it.
#
# THE CELLS. The stand goes in the flower glade (the studio's `flowers` view, camera cell 154,98), open ground with no
# roof by design; the watcher is set down five cells west of it, inside the 4 to 12 cells colonists stand at. The
# first run of this feature is the one that tells whether those cells are free: a failed placement names the cell.
@review @requires:nelim.pickletools.screenshotstudio
Feature: the Workshop gallery, in the zen meadow studio

  Background:
    Given the save "nelim-zen-meadow-studio" is loaded
    And Nelim's Pickle Tools: the screen is clear

  @timeout:110
  Scenario: gallery 01, 02, 03: the fuse smoking, the launch, the burst, from one salvo
    Given a "FS_FireworkStand" is built at (154, 98)
    And Firework Stand: the stand at x=154 z=98 is loaded with 1 launchers
    And Firework Stand: "Miel" is bored
    And Firework Stand: "Miel" is placed at x=149 z=98
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And game speed is normal
    When I zoom all the way in
    And I move the camera to (154, 100)
    And Firework Stand: "Miel" is ordered to watch the stand at x=154 z=98
    Then Firework Stand: the stand at x=154 z=98 comes to hold 0 launchers within 60 seconds
    When I wait 40 ticks
    Then Firework Stand: at least 4 smoke puffs are near the stand at x=154 z=98 now
    And I take a screenshot "gallery 01: the fuse smoking at the foot of the stand"
    When I wait 40 ticks
    Then I take a screenshot "gallery 02: the puff and the sparks as the rocket leaves"
    When I zoom all the way in
    And I move the camera to (154, 104)
    And I wait 50 ticks
    Then I take a screenshot "gallery 03a: the burst over the meadow"
    When I wait 50 ticks
    Then I take a screenshot "gallery 03b: the burst over the meadow"
    When I wait 50 ticks
    Then I take a screenshot "gallery 03c: the burst over the meadow"
    And no errors were logged

  @timeout:110
  Scenario: gallery 04: the ground lit at night as the rocket leaves
    Given a "FS_FireworkStand" is built at (154, 98)
    And Firework Stand: the stand at x=154 z=98 is loaded with 1 launchers
    And Firework Stand: "Miel" is bored
    And Firework Stand: "Miel" is placed at x=149 z=98
    And I set the weather to "Clear"
    And I set the hour to 23
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And game speed is normal
    When I zoom all the way in
    And I move the camera to (154, 100)
    And Firework Stand: "Miel" is ordered to watch the stand at x=154 z=98
    Then Firework Stand: "Miel" is watching the stand at x=154 z=98
    # The first run (and its rerun) never saw the light within 60 s with the watcher at the stand. Two steps tell the two
    # possible causes apart: the stand is asked to have fired (its launcher spent), then the light is awaited.
    And Firework Stand: the stand at x=154 z=98 comes to hold 0 launchers within 60 seconds
    And Firework Stand: the light of the stand at x=154 z=98 comes on within 30 seconds
    And I take a screenshot "gallery 04: the ground lit at night as the rocket leaves"
    When I wait 100 ticks
    Then I take a screenshot "gallery 04b: the burst at night"
    And no errors were logged

  @timeout:110
  Scenario: gallery 05: the stand counting down its reload, with its inspect pane
    Given a "FS_FireworkStand" is built at (154, 98)
    And Firework Stand: the stand at x=154 z=98 is loaded with 4 launchers
    And Firework Stand: "Miel" is bored
    And Firework Stand: "Miel" is placed at x=149 z=98
    And game speed is normal
    When I zoom all the way in
    And I move the camera to (154, 98)
    And Firework Stand: "Miel" is ordered to watch the stand at x=154 z=98
    Then Firework Stand: the stand at x=154 z=98 comes to hold 3 launchers within 60 seconds
    When Nelim's Pickle Tools: windows are allowed to open again
    And Firework Stand: I select the stand at x=154 z=98
    And I wait 60 ticks
    Then I take a screenshot "gallery 05: the stand counting down its reload"
    And no errors were logged

  @timeout:110
  Scenario: gallery 06: the blueprint, placed through the Architect menu
    Given research "IEDs" is finished
    When I use the build designator for "FS_FireworkStand" at (154, 98)
    And I zoom all the way in
    And I move the camera to (154, 98)
    And I wait 30 ticks
    Then a blueprint for "FS_FireworkStand" is at (154, 98)
    And I take a screenshot "gallery 06: the blueprint of the firework stand"
    And no errors were logged
