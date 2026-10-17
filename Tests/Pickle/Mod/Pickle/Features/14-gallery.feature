# The Workshop gallery (PUBLICATION.md, "Gallery"), produced by a scenario of its own so that it can be replayed after
# any change of the mod. It is not a test of the mod: the functional scenarios of features 01 to 13 are that. What it
# asserts is only what makes an image worth keeping (the stand exists, is loaded, the salvo really happened), and what
# a person opens afterwards is the image.
#
# THE PLACE. The Sanctuaire de Nelim of SanctuaryBacklot (GALLERY.md), through the save `Nelims-tribe` and the pass `vitrine`
# (`wsl-deps.vitrine.map`, the Sanctuary's own minimum list plus SanctuaryBacklot itself, nothing left out). The place is
# `calm-zone` (SANCTUAIRE-LIEUX.md): a pale cream square of about 11 x 11 cells (x 195-205, z 181-191, all free), ringed with wild
# flowers, bamboo on its west and north sides, open sky, and a large stele on its east side at (212, 190). It replaces the bare
# brown clearing of the first plan: a firework is a thing of light, and light reads on a pale ground and against dark bamboo, not on
# brown earth that eats it. The stand stands on the south edge of the square at (200, 183), so that the rocket climbs north over
# the flowers and the bamboo.
#
# THE STORY (owner's rule: a single story, one photographer, 2026-10-02 and 2026-10-14; Nelim is the protagonist of every
# picture, 2026-10-14). Midsummer eve. NELIM, the save's only colonist (the fixture gives her her face, her trousers and her brown
# eyes: a scenario dresses nothing of hers), keeps one square of quiet for herself, and tonight she gives it to the one show of the
# year. She sets the stand down, lights it in the late afternoon and waits for the dark, her two dogs beside her: SHOGUN the
# labrador and YUKI the husky, who watch her and not the sky (they face the camera, 2026-10-14). There is no other character and
# no set: the cream square, the flowers, the bamboo, the stele and the sky are the decor, and the only light on the night ground is
# the stand's own (the stand throws it for the length of the rocket's departure, it is not a lamp). The hour is the photographer's
# choice for each image; the story goes on from late afternoon to the dead of night.
#
# HOW THE FRAMES ARE MADE TRUE (what the first four runs taught). (1) The camera is framed BEFORE the game runs: the framing step
# waits ninety frames, and at normal speed those are ninety ticks of the salvo, which is why "the launch" caught the stand before
# the rocket left on one run and the trails on another. (2) The stand's own tick is the clock: T is the tick the fuse is lit (the
# step "has fired"), the rocket leaves at T + 60 (the light comes on, 240 ticks), the burst hangs about 100 ticks after the light
# (read off 04a of the run of 2026-10-14). A picture is taken at a fixed distance from one of those two events, then the game is
# paused so that nothing drifts between the step and the shutter. (3) The watching job puts the watcher on a cell the game picks, 4
# to 12 cells from the stand, out of any frame; once the stand has fired it needs no audience (CompFireworkStand: the departure and
# the light run on the stand's tick), so Nelim is put on her own cell then, facing the way the picture wants her. (4) The map is held
# at 22 degrees so that she does not sweat or blush at 39, and her own face is the last step before the shutter, with no tick
# between (SanctuaryBacklot GALERIE.md).
#
# THE SHOOTING PLAN (one line per image: place, moment, subject, composition, life, what it says). Zoom N is the camera's
# half-height (PickleTools docs/GALERIE.md): 2N cells high, about 3.56N wide, a cell is 540 / N px, so a SMALLER N is closer.
#   1  fuse    | calm-zone, 16h (late afternoon: grey smoke on a pale ground, at dusk on brown it was a dark stain), T + 40, zoom 3 on
#              | (199, 184), 10.7 x 6 cells | the stand at the bottom centre with the thread of smoke over it, Nelim three cells west in
#              | profile, facing it, Shogun at the right edge facing us | "she has lit it, and waits".
#   2  launch  | same square, 19h (dusk: the trails read, the sky is still faintly lit), the light + 25 ticks, zoom 7 on (199, 189), 25 x 14
#              | cells | the rocket two or three cells up its climb with its purple trails and the sparks, the stand at the bottom, Nelim
#              | from behind looking north, the two dogs facing us | "it leaves".
#   3  light   | 23h (night), the light + 30 ticks, zoom 4.5 on (199, 184), 16 x 9 cells | the cream square lit warm round the stand, all else
#              | dark; Nelim in profile beside it, her face lit, the dogs facing us at the edge of the glow | "the stand lights the night, it is
#              | not a lamp".
#   4  burst   | 23h, the light + 100 ticks, zoom 8.5 on (200, 190), 30 x 17 cells | the burst high over the flowers and the bamboo (about 12 cells
#              | north of the stand), the stele at the right, Nelim and the dogs small at the bottom | "the show itself" (a burst does not read by
#              | day, 2026-09-25: a night picture).
#   5  reload  | 12h, zoom 5 on (198, 184), the interface on but cleaned (colonist bar, resources, alerts, learning helper and tooltips hidden),
#              | the inspect pane open | the pane reads "Fireworks loaded 3 / 10" and "Reloading"; Nelim at her post | "the stand reloads, one
#              | launcher a salvo".
#   6  menu    | 12h, the Architect Joy category open | the menu itself, a screenshot of what it is | "where to find it".
# Pictures 1 to 4 hide the interface (the game's own screenshot mode) and 5 and 6 show it. ClearScreen keeps a log viewer or a notice
# of another mod out of every frame.
@review @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.clearscreen @requires:nelim.pickletools.clickdiagnostics @requires:nelim.pickletools.colonistrace
Feature: the Workshop gallery, in the Sanctuary's calm zone

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: the screen is clear
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And Nelim's Pickle Tools: the temperature of the map is 22 degrees

  @timeout:150
  Scenario: gallery 1: the fuse smoking, Nelim waiting
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 1 launchers
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: an adult animal of kind "Labrador" named "Shogun" is spawned at (203, 185)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (203, 185) facing South
    And Firework Stand: "Shogun" is told to stay where they stand
    And I set the weather to "Clear"
    And I set the hour to 16
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the cell (199, 184) at zoom 3
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 has fired within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (197, 184) facing East
    And Firework Stand: "Nelim" is told to stay where they stand
    And Nelim's Pickle Tools: I let 40 ticks pass
    Then Firework Stand: at least 4 smoke puffs are near the stand at x=200 z=183 now
    When game speed is paused
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 01: the fuse smoking, Nelim waiting"
    And no errors were logged

  @timeout:340
  Scenario: gallery 2: the rocket leaving at dusk
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 1 launchers
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: an adult animal of kind "Labrador" named "Shogun" is spawned at (203, 184)
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Yuki" is spawned at (204, 185)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (203, 184) facing South
    And Nelim's Pickle Tools: the animal "Yuki" stands at (204, 185) facing South
    And Firework Stand: "Shogun" is told to stay where they stand
    And Firework Stand: "Yuki" is told to stay where they stand
    And I set the weather to "Clear"
    And I set the hour to 19
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the cell (199, 189) at zoom 7
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 has fired within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (197, 184) facing North
    And Firework Stand: "Nelim" is told to stay where they stand
    Then Firework Stand: the light of the stand at x=200 z=183 comes on within 30 seconds
    When Nelim's Pickle Tools: I let 25 ticks pass
    And game speed is paused
    And Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 02: the rocket leaving at dusk"
    And no errors were logged

  @timeout:340
  Scenario: gallery 3: the ground lit at night as the rocket leaves
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 1 launchers
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: an adult animal of kind "Labrador" named "Shogun" is spawned at (203, 184)
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Yuki" is spawned at (203, 182)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (203, 184) facing South
    And Nelim's Pickle Tools: the animal "Yuki" stands at (203, 182) facing South
    And Firework Stand: "Shogun" is told to stay where they stand
    And Firework Stand: "Yuki" is told to stay where they stand
    And I set the weather to "Clear"
    And I set the hour to 23
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the cell (199, 184) at zoom 4.5
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 has fired within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (197, 184) facing East
    And Firework Stand: "Nelim" is told to stay where they stand
    Then Firework Stand: the light of the stand at x=200 z=183 comes on within 30 seconds
    When Nelim's Pickle Tools: I let 30 ticks pass
    And game speed is paused
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 03: the ground lit at night as the rocket leaves"
    And no errors were logged

  @timeout:340
  Scenario: gallery 4: the burst at night, over the flowers and the bamboo
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 1 launchers
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: an adult animal of kind "Labrador" named "Shogun" is spawned at (203, 184)
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Yuki" is spawned at (204, 185)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (203, 184) facing South
    And Nelim's Pickle Tools: the animal "Yuki" stands at (204, 185) facing South
    And Firework Stand: "Shogun" is told to stay where they stand
    And Firework Stand: "Yuki" is told to stay where they stand
    And I set the weather to "Clear"
    And I set the hour to 23
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the cell (200, 190) at zoom 8.5
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 has fired within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (197, 184) facing North
    And Firework Stand: "Nelim" is told to stay where they stand
    Then Firework Stand: the light of the stand at x=200 z=183 comes on within 30 seconds
    When Nelim's Pickle Tools: I let 100 ticks pass
    And game speed is paused
    And Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 04: the burst at night"
    And no errors were logged

  @timeout:150
  Scenario: gallery 5: the stand counting down its reload, with its inspect pane
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 4 launchers
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And I set the weather to "Clear"
    And I set the hour to 12
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the item and name labels are hidden
    When Nelim's Pickle Tools: I frame the cell (198, 184) at zoom 5
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 comes to hold 3 launchers within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (197, 184) facing East
    And Firework Stand: "Nelim" is told to stay where they stand
    And Nelim's Pickle Tools: windows are allowed to open again
    And Firework Stand: I select the stand at x=200 z=183
    And Nelim's Pickle Tools: I move the mouse to (1500, 400)
    And Nelim's Pickle Tools: I let 60 ticks pass
    Then I take a screenshot "gallery 05: the stand counting down its reload"
    And no errors were logged

  @timeout:150
  Scenario: gallery 6: the Architect menu lists the stand
    Given research "IEDs" is finished
    And I set the weather to "Clear"
    And I set the hour to 12
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    Then Firework Stand: the Architect menu lists the stand
    When Nelim's Pickle Tools: windows are allowed to open again
    And Nelim's Pickle Tools: I frame the cell (200, 186) at zoom 6
    And Firework Stand: I open the Architect category of the stand
    And Nelim's Pickle Tools: I move the mouse to (1500, 400)
    And Nelim's Pickle Tools: I let 30 ticks pass
    Then I take a screenshot "gallery 06: the Architect menu, the stand in the Joy category"
    And no errors were logged
