# The Workshop gallery (PUBLICATION.md, "Gallery"), produced by a scenario of its own so that it can be replayed after
# any change of the mod. It is not a test of the mod: the functional scenarios of features 01 to 13 are that. What it
# asserts is only what makes an image worth keeping (the stand exists, is loaded, the salvo really happened), and what
# a person opens afterwards is the image.
#
# THE PLACE. The Sanctuaire de Nelim of SanctuaryBacklot, the shared place of every gallery (GALLERY.md), through the save
# `Nelims-tribe` and the pass `vitrine` (`wsl-deps.vitrine.map`). The place is `bare-clearing` (SANCTUAIRE-LIEUX.md): bare brown
# earth with a column of wild flowers on its west edge, no roof, no furniture, about 18 x 10 cells (x 186-204, z 147-157). Chosen
# against the empty photographs of the other places because a firework needs open sky and a ground the sparks and the light can
# be read on: the glade is a plain dark floor at night, the one place where the stand's own light is the only light. The old
# studio fixture `nelim-zen-meadow-studio` (PickleTools' ScreenshotStudio) is not used any more: the gallery plays in the Sanctuary.
#
# THE INTERFACE. The game's own screenshot mode (`studio presentation mode is enabled`) hides the HUD for the pictures
# that show the world (01 to 04b) and is left off for the two that show the interface (05, 06), which are there to show
# it. ClearScreen keeps a log viewer or a notice of another mod out of every frame.
#
# THE ZOOM. Every picture is taken at zoom 9 (Nelim's Pickle Tools: I frame the cell ... at zoom 9, 2026-10-12), not "all the way in":
# the Sanctuary's own scale is a 28 x 16 cell window, the stand about 70 px, and the picture is then cropped around the subject
# (PUBLICATION.md, "Gallery") so that what it has to prove fills half the height. The window is centred west of the stand, so that the
# orange smiley of the east edge stays out of it; it is set north of the stand for the burst, which rises above it. The vanometric
# cell at the east edge of the clearing is hidden for the run.
#
# THE CELLS. The stand stands in the middle of the clearing at (198, 152); the watcher is set down five cells west of it
# (193, 152), inside the 4 to 12 cells colonists stand at. The cells are read off the clearing's frame (x 186-204, z 147-157);
# the first run of this feature is the one that tells whether they are free: a failed placement names the cell.
#
# THE STORY OF THE SERIES (owner's rule, 2026-10-02: every gallery picture is a staged photograph, except menus and windows).
# Midsummer eve in the bare clearing. Miel, the colony's quiet gardener, has laid a small plank deck at the edge of the clearing,
# against the wild flowers, set a standing lamp and a stool beside it and planted roses along its edge, to watch the one show of
# the year. The same set is in every photograph of the series (01 to 04b), put up before the picture and taken down after it.
# Miel: silver-white hair in a bob, so that it catches the warm light of the burst and the light of the launch; a teal collar
# shirt and cream trousers, cool colours that stand out against the warm light and the purple streaks; a slight build. No
# tattoo: none would mean anything here. Face: Female_NarrowNormal (Miel is assumed female: the step refuses the other gender and
# names it), no beard. The standing lamp is NOT powered (it gives no light), so that the only light on the night ground is the
# stand's own. Nelim, the save's one colonist, is in her house, far from the frame. The animals of the save are sent away.
# Pictures 05 (the inspect pane) and 06 (the blueprint) are the interface and are not staged.
@review @requires:nelim.pickletools.screenshotstudio
Feature: the Workshop gallery, in the Sanctuary's bare clearing

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: the screen is clear
    And Nelim's Sanctuary: I am at the sanctuary "bare-clearing"
    And Nelim's Sanctuary: the vanometric cell of the sanctuary is hidden
    And Nelim's Pickle Tools: a colonist "Miel" of kind "Colonist" exists

  @timeout:110
  Scenario: gallery 01, 02, 03: the fuse smoking, the launch, the burst, from one salvo
    Given a "FS_FireworkStand" is built at (198, 152)
    And Firework Stand: the stand at x=198 z=152 is loaded with 1 launchers
    And Firework Stand: "Miel" is bored
    And Firework Stand: "Miel" is placed at x=193 z=152
    # The set and the subject, put up before the picture (see the story at the top).
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (191, 151) to (195, 154)
    And Nelim's Pickle Tools: I place the decor "StandingLamp" at (191, 151)
    And Nelim's Pickle Tools: I place the decor "Stool" at (192, 154)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (196, 151)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (196, 154)
    And Nelim's Pickle Tools: "Miel" body type is Thin
    And Nelim's Pickle Tools: "Miel" hairstyle is "Bob"
    And Nelim's Pickle Tools: "Miel" hair colour is rgb (235, 235, 240)
    And Nelim's Pickle Tools: "Miel" head type is "Female_NarrowNormal"
    And Nelim's Pickle Tools: "Miel" beard is "none"
    And Nelim's Pickle Tools: "Miel" wears "Apparel_CollarShirt" dyed rgb (30, 120, 130)
    And Nelim's Pickle Tools: "Miel" wears "Apparel_Pants" dyed rgb (235, 225, 200)
    And I set the weather to "Clear"
    And I set the hour to 20
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And game speed is normal
    When Nelim's Pickle Tools: I frame the cell (192, 153) at zoom 9
    And Firework Stand: "Miel" is ordered to watch the stand at x=198 z=152
    Then Firework Stand: the stand at x=198 z=152 has fired within 60 seconds
    When I wait 40 ticks
    Then Firework Stand: at least 4 smoke puffs are near the stand at x=198 z=152 now
    And I take a screenshot "gallery 01: the fuse smoking at the foot of the stand"
    When I wait 40 ticks
    Then I take a screenshot "gallery 02: the puff and the sparks as the rocket leaves"
    When Nelim's Pickle Tools: I frame the cell (194, 160) at zoom 9
    And I wait 50 ticks
    Then I take a screenshot "gallery 03a: the burst over the clearing"
    When I wait 50 ticks
    Then I take a screenshot "gallery 03b: the burst over the clearing"
    When I wait 50 ticks
    Then I take a screenshot "gallery 03c: the burst over the clearing"
    When Nelim's Pickle Tools: the decor is removed
    And Nelim's Pickle Tools: "Miel" gets back the clothes it had
    And no errors were logged

  # Raised from 110 (2026-09-27, four runs in a row: f586, e0f0, 6702, ad7c): the tick rate itself runs well under real
  # time in the scene (software-rendered xvfb), so the step waiting for the light needs real-time headroom past its own
  # 300s budget, and the scenario needs headroom past that for its teardown.
  @timeout:340
  Scenario: gallery 04: the ground lit at night as the rocket leaves
    Given a "FS_FireworkStand" is built at (198, 152)
    And Firework Stand: the stand at x=198 z=152 is loaded with 1 launchers
    And Firework Stand: "Miel" is bored
    And Firework Stand: "Miel" is placed at x=193 z=152
    # The set and the subject, put up before the picture (see the story at the top).
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (191, 151) to (195, 154)
    And Nelim's Pickle Tools: I place the decor "StandingLamp" at (191, 151)
    And Nelim's Pickle Tools: I place the decor "Stool" at (192, 154)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (196, 151)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (196, 154)
    And Nelim's Pickle Tools: "Miel" body type is Thin
    And Nelim's Pickle Tools: "Miel" hairstyle is "Bob"
    And Nelim's Pickle Tools: "Miel" hair colour is rgb (235, 235, 240)
    And Nelim's Pickle Tools: "Miel" head type is "Female_NarrowNormal"
    And Nelim's Pickle Tools: "Miel" beard is "none"
    And Nelim's Pickle Tools: "Miel" wears "Apparel_CollarShirt" dyed rgb (30, 120, 130)
    And Nelim's Pickle Tools: "Miel" wears "Apparel_Pants" dyed rgb (235, 225, 200)
    And I set the weather to "Clear"
    And I set the hour to 23
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And game speed is normal
    When Nelim's Pickle Tools: I frame the cell (192, 153) at zoom 9
    And Firework Stand: "Miel" is ordered to watch the stand at x=198 z=152
    Then Firework Stand: "Miel" is watching the stand at x=198 z=152
    # The first run (and its rerun) never saw the light within 60 s with the watcher at the stand. Two steps tell the two
    # possible causes apart: the stand is asked to have fired (its launcher spent), then the light is awaited.
    And Firework Stand: the stand at x=198 z=152 has fired within 60 seconds
    And Firework Stand: the light of the stand at x=198 z=152 comes on within 30 seconds
    And I take a screenshot "gallery 04: the ground lit at night as the rocket leaves"
    When I wait 100 ticks
    Then I take a screenshot "gallery 04b: the burst at night"
    When Nelim's Pickle Tools: the decor is removed
    And Nelim's Pickle Tools: "Miel" gets back the clothes it had
    And no errors were logged

  @timeout:110
  Scenario: gallery 05: the stand counting down its reload, with its inspect pane
    Given a "FS_FireworkStand" is built at (198, 152)
    And Firework Stand: the stand at x=198 z=152 is loaded with 4 launchers
    And Firework Stand: "Miel" is bored
    And Firework Stand: "Miel" is placed at x=193 z=152
    And I set the weather to "Clear"
    And I set the hour to 12
    And game speed is normal
    When Nelim's Pickle Tools: I frame the cell (194, 152) at zoom 9
    And Firework Stand: "Miel" is ordered to watch the stand at x=198 z=152
    Then Firework Stand: the stand at x=198 z=152 comes to hold 3 launchers within 60 seconds
    When Nelim's Pickle Tools: windows are allowed to open again
    And Firework Stand: I select the stand at x=198 z=152
    And I wait 60 ticks
    Then I take a screenshot "gallery 05: the stand counting down its reload"
    And no errors were logged

  @timeout:110
  Scenario: gallery 06: the blueprint, placed through the Architect menu
    Given research "IEDs" is finished
    And I set the weather to "Clear"
    And I set the hour to 12
    When I use the build designator for "FS_FireworkStand" at (198, 152)
    And Nelim's Pickle Tools: I frame the cell (194, 152) at zoom 9
    And I wait 30 ticks
    Then a blueprint for "FS_FireworkStand" is at (198, 152)
    And I take a screenshot "gallery 06: the blueprint of the firework stand"
    And no errors were logged
