# The Workshop gallery (PUBLICATION.md, "Gallery"), produced by a scenario of its own so that it can be replayed after
# any change of the mod. It is not a test of the mod: the functional scenarios of features 01 to 13 are that. What it
# asserts is only what makes an image worth keeping (the stand exists, is loaded, the salvo really happened), and what
# a person opens afterwards is the image.
#
# THE PLACE. The Sanctuaire de Nelim of SanctuaryBacklot (GALLERY.md), through the save `Nelims-tribe` and the pass `vitrine`
# (`wsl-deps.vitrine.map`). The place is `bare-clearing` (SANCTUAIRE-LIEUX.md): bare brown earth with a column of wild flowers on
# its west edge, no roof, about 18 x 10 cells (x 186-204, z 147-157). A firework needs open sky and a plain ground the sparks and
# the light can be read on. The stand stands in the middle of the clearing at (198, 152).
#
# THE STORY (owner's rule: a single story, one photographer, 2026-10-02 and 2026-10-14). Midsummer eve in the clearing. NELIM,
# the save's colonist and the protagonist of every picture (the fixture gives her her face, her trousers and her brown eyes: a
# scenario dresses nothing of hers), has come to watch the one show of the year. MIEL, the colony's quiet gardener, a guest of
# the story and not its subject, has laid a small plank deck at the edge of the clearing and set a stool and roses on it, and sits
# out the show there. The day goes on from dusk to the dead of night, and the hour is the photographer's choice for each image.
# The standing lamp is NOT powered, so that the only light on the night ground is the stand's own.
#
# THE SHOOTING PLAN (one line per image: place, moment, subject, composition, life, what it says). Zoom N is the camera's
# half-height (PickleTools docs/GALERIE.md): 2N cells high, about 3.56N wide, a cell is 540 / N px, so a SMALLER N is closer.
#   1  fuse    | bare-clearing, 18h (dusk), the stand, tight: zoom 3 on (197, 153), 6 x 11 cells, the rack large and the thread of
#              | smoke over it, grey against the brown earth | nobody in frame, the show has not begun | "something is about to go up".
#   2  launch  | same salvo 40 ticks later, zoom 5 on (194, 152), 10 x 18 cells | Nelim on the left at her watch cell, the deck and
#              | Miel behind her, the stand on the right throwing its trails and sparks | "she watches, and it leaves".
#   3  light   | 23h (night), zoom 5 on (194, 152) | Nelim, the deck, the stand; the ground lit warm for the length of the burst, all
#              | else dark | "the stand lights the night, it is not a lamp".
#   4  burst   | 23h, zoom 12 on (197, 162), 24 x 43 cells, the stand at the bottom edge and the sky above it, three pictures 60
#              | ticks apart after the light comes on | the burst high over the clearing, Nelim in frame at the bottom left, the
#              | ground still lit | "the show itself" (a burst does not read by day, 2026-09-25: it is a night picture).
#   5  reload  | 12h, zoom 5 on (195, 152), the interface on, the inspect pane open | Nelim at her post; the pane reads "Fireworks
#              | loaded 3 / 10" and "Reloading" | "the stand reloads, one launcher a salvo".
#   6  menu    | 12h, the Architect Joy category open, zoom 5 | the menu itself, a screenshot of what it is | "where to find it".
# The set (deck, stool, roses) is put up before pictures 2 to 4 and taken down after each one. Pictures 1 to 4 hide the interface
# (the game's own screenshot mode) and 5 and 6 show it. ClearScreen keeps a log viewer or a notice of another mod out of every frame.
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
  Scenario: gallery 1 and 2: the fuse smoking, then the launch, from one salvo
    Given a "FS_FireworkStand" is built at (198, 152)
    And Firework Stand: the stand at x=198 z=152 is loaded with 1 launchers
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=193 z=152
    # The set: Miel and her deck, put up before the picture and taken down after it (see the story at the top).
    And Firework Stand: "Miel" is placed at x=192 z=153
    And Firework Stand: "Miel" is told to stay where they stand
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
    And I set the hour to 18
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And game speed is normal
    When Nelim's Pickle Tools: I frame the cell (197, 153) at zoom 3
    And Firework Stand: "Nelim" is ordered to watch the stand at x=198 z=152
    Then Firework Stand: the stand at x=198 z=152 has fired within 60 seconds
    When I wait 40 ticks
    Then Firework Stand: at least 4 smoke puffs are near the stand at x=198 z=152 now
    And I take a screenshot "gallery 01: the fuse smoking at the foot of the stand"
    When Nelim's Pickle Tools: I frame the cell (194, 152) at zoom 5
    And I wait 40 ticks
    Then I take a screenshot "gallery 02: the launch, Nelim watching"
    When Nelim's Pickle Tools: the decor is removed
    And Nelim's Pickle Tools: "Miel" gets back the clothes it had
    And no errors were logged

  # Raised from 110 (2026-09-27): the tick rate runs well under real time in the scene (software-rendered xvfb), so the step
  # waiting for the light needs real-time headroom past its own 300s budget.
  @timeout:340
  Scenario: gallery 3: the ground lit at night as the rocket leaves
    Given a "FS_FireworkStand" is built at (198, 152)
    And Firework Stand: the stand at x=198 z=152 is loaded with 1 launchers
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=193 z=152
    # The set: Miel and her deck, put up before the picture and taken down after it (see the story at the top).
    And Firework Stand: "Miel" is placed at x=192 z=153
    And Firework Stand: "Miel" is told to stay where they stand
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
    When Nelim's Pickle Tools: I frame the cell (194, 152) at zoom 5
    And Firework Stand: "Nelim" is ordered to watch the stand at x=198 z=152
    Then Firework Stand: "Nelim" is watching the stand at x=198 z=152
    And Firework Stand: the stand at x=198 z=152 has fired within 60 seconds
    And Firework Stand: the light of the stand at x=198 z=152 comes on within 30 seconds
    And I take a screenshot "gallery 03: the ground lit at night as the rocket leaves"
    When Nelim's Pickle Tools: the decor is removed
    And Nelim's Pickle Tools: "Miel" gets back the clothes it had
    And no errors were logged

  @timeout:340
  Scenario: gallery 4: the burst at night, over the clearing
    Given a "FS_FireworkStand" is built at (198, 152)
    And Firework Stand: the stand at x=198 z=152 is loaded with 1 launchers
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=193 z=152
    # The set: Miel and her deck, put up before the picture and taken down after it (see the story at the top).
    And Firework Stand: "Miel" is placed at x=192 z=153
    And Firework Stand: "Miel" is told to stay where they stand
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
    When Nelim's Pickle Tools: I frame the cell (197, 162) at zoom 12
    And Firework Stand: "Nelim" is ordered to watch the stand at x=198 z=152
    Then Firework Stand: the stand at x=198 z=152 has fired within 60 seconds
    And Firework Stand: the light of the stand at x=198 z=152 comes on within 30 seconds
    When I wait 100 ticks
    Then I take a screenshot "gallery 04a: the burst at night"
    When I wait 60 ticks
    Then I take a screenshot "gallery 04b: the burst at night"
    When I wait 60 ticks
    Then I take a screenshot "gallery 04c: the burst at night"
    When Nelim's Pickle Tools: the decor is removed
    And Nelim's Pickle Tools: "Miel" gets back the clothes it had
    And no errors were logged

  @timeout:110
  Scenario: gallery 5: the stand counting down its reload, with its inspect pane
    Given a "FS_FireworkStand" is built at (198, 152)
    And Firework Stand: the stand at x=198 z=152 is loaded with 4 launchers
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=193 z=152
    And I set the weather to "Clear"
    And I set the hour to 12
    And game speed is normal
    When Nelim's Pickle Tools: I frame the cell (195, 152) at zoom 5
    And Firework Stand: "Nelim" is ordered to watch the stand at x=198 z=152
    Then Firework Stand: the stand at x=198 z=152 comes to hold 3 launchers within 60 seconds
    When Nelim's Pickle Tools: windows are allowed to open again
    And Firework Stand: I select the stand at x=198 z=152
    And I wait 60 ticks
    Then I take a screenshot "gallery 05: the stand counting down its reload"
    And no errors were logged

  @timeout:110
  Scenario: gallery 6: the Architect menu lists the stand
    Given research "IEDs" is finished
    And I set the weather to "Clear"
    And I set the hour to 12
    Then Firework Stand: the Architect menu lists the stand
    When Nelim's Pickle Tools: I frame the cell (195, 152) at zoom 5
    And Firework Stand: I open the Architect category of the stand
    And I wait 30 ticks
    And I take a screenshot "gallery 06: the Architect menu, the stand in the Joy category"
    And no errors were logged
