# The Workshop gallery (PUBLICATION.md, "Gallery"), produced by a scenario of its own so that it can be replayed after
# any change of the mod. It is not a test of the mod: the functional scenarios of features 01 to 13 are that. What it
# asserts is only what makes an image worth keeping (the stand exists, is loaded, the salvo really happened), and what
# a person opens afterwards is the image.
#
# THE PLACE. The Sanctuaire de Nelim of SanctuaryBacklot (GALLERY.md), through the save `Nelims-tribe` and the pass `vitrine`
# (`wsl-deps.vitrine.map`, the Sanctuary's own minimum list plus SanctuaryBacklot itself, nothing left out). The place is
# `calm-zone` (SANCTUAIRE-LIEUX.md): a pale cream square of about 11 x 11 cells (x 195-205, z 181-191, all free), ringed with wild
# flowers, bamboo on its west and north sides, open sky, and a large stele on its east side at (212, 190). A firework is a thing of
# light, and light reads on a pale ground and against dark bamboo, not on brown earth. The stand stands on the south edge of the
# square at (200, 183), so that the rocket climbs north over the flowers and the bamboo. Weather clear in every scene.
#
# THE STORY (one story, one photographer; Nelim is the protagonist of every picture). Midsummer eve. NELIM, the save's only
# colonist (the fixture gives her her face, her brown eyes and her trousers; each scene below re-dresses her), keeps one square of
# quiet for herself and tonight gives it to the one show of the year. She changes clothes as the day goes: the saffron of the
# afternoon, the teal of dusk, the parka of the night chill. Her two dogs, SHOGUN the labrador and YUKI the husky, are with her and
# watch her and not the sky: they face the camera (South) in scenes 1 to 4. No other character, no set: the decor of each picture is
# its own, small, named below, and removed after the shot (`the decor is removed`). EPISODES, in the order of the pictures: 1 late afternoon (16h), she has lit the fuse and waits; 2 dusk (19h), the rocket leaves, supper forgotten; 3 night (23h), the stand lights the square; 4 the same night, a hundred ticks later, the burst; 5 the morning after (9h), she reloads for the next one; 6 the menu that tells the reader where to find it (noon, outside the story). The only light on the night ground is the
# stand's own (the stand throws it for the length of the rocket's departure, it is not a lamp). Time runs from 16h on the eve to 9h the morning after; each hour is the next beat of one evening.
#
# HOW THE FRAMES ARE MADE TRUE (what the first runs taught). (1) The camera is framed BEFORE the game runs: the framing step waits
# ninety frames, ninety ticks of the salvo at normal speed. (2) The stand's own tick is the clock: T is the tick the fuse is lit
# (the step "has fired"), the rocket leaves at T + 60 (the light comes on, 240 ticks), the burst hangs about 100 ticks after the
# light (read off 04a of the run of 2026-10-14). A picture is taken at a fixed distance from one of those two events, then the game
# is paused so that nothing drifts between the step and the shutter. (3) The watching job puts the watcher on a cell the game picks,
# 4 to 12 cells from the stand; once the stand has fired it needs no audience, so Nelim is put on her own cell then. (4) The map is
# held at 22 degrees so that she does not sweat or blush at 39; her own face (`Nelim has her own face`: BrowNormal, MouthSmirkSmile,
# normal+blink) is set after her clothes, then the scene's own mouth, brows and lids (face-part steps of ColonistRace), no tick
# between them and the shutter. CANON (SanctuaryBacklot NELIM-PROFIL.md): her hair is a high ponytail (Core "Ponytails" here), never a bun; her palette is emerald, deep blue, brown, beige, blood red, gold. HAT RULE (owner, 2026-10-18): a hat only with long loose hair ("Long", never a ponytail or a bun) and Show Hair Under Stuff in the map, seeded by Tests/Pickle/config/vitrine/Mod_3255379190_ShowHairMod.xml; only scene 3 wears one, and if the hair clips the hat is taken off. Her garments: the first `wears` undresses her, so every scene dresses her whole: shirt, trousers,
# then the rest.
#
# THE SHOOTING PLAN, scored against GALLERY.md "Shotlist : critères d'une scène à 4/5" (a to j). Zoom N is the camera's half-height
# (PickleTools docs/GALERIE.md): 2N cells high, about 3.56N wide, a cell is 540 / N px, so a SMALLER N is closer.
# Run 888d (2026-10-21): a plant placed on a PlantPot cell was refused by the plain step; the pot and its plant now go through one NPT step (compiled, not played).
#
#  1 fuse   (score 4)
#   a. calm-zone, 16h, clear, T + 40 ticks after the fuse is lit.
#   b. decor: PlantPot at (195, 186) holding Plant_Daylily fully grown (the midsummer flower), Hay at (202, 186) as the dogs' bed.
#   c. life: Plant_Daylily; Shogun (labrador) at (203, 185) facing South, i.e. the camera.
#   d. Nelim: ShirtRuffle dyed blood red (150, 30, 40), Pants dyed brown (92, 64, 40) (the party outfit); hairstyle Ponytails, near-black brown (42, 30, 24);
#      expression: her own face, the smirk smile and the blink (calm, pleased).
#   e. action: the WatchStand job, kept in profile (facing East) three cells west of the stand: she has lit it and waits.
#   f. zoom 3 on (199, 184), 10.7 x 6 cells; the stand at the bottom centre with the thread of smoke over it, Nelim left of it,
#      Shogun at the right edge, the daylily pot at the left edge as foreground; a daylight afternoon, grey smoke on a pale ground.
#   g. subject: the lit fuse. "She has lit it, and waits."
#   h. risk: the thread of smoke is thin and fades (the fleck FS_FuseSmoke, seen on the captures of 2026-09 only). Plan: the step
#      "at least 4 smoke puffs are near the stand now" must pass before the shutter; the picture is taken 40 ticks after the fuse
#      and the game is paused; if the smoke does not read, the fix is a closer zoom (2.5), not a darker hour.
#   i. not a plate: a pot, a dog and a woman at three depths, not a row.   j. the mod: the stand, its fuse and its smoke.
#   subtitle: "Nelim has lit the fuse and waits."
#
#  2 launch (score 4)
#   a. calm-zone, 19h (dusk, sky still faintly lit), clear, the light + 25 ticks.
#   b. decor: two Hay at (202, 186) and (204, 186) (the dogs' supper bed), Plant_YellowTallGrass fully grown at (195, 187) and
#      (196, 188) (straw-coloured foreground).
#   c. life: Plant_YellowTallGrass; Shogun at (203, 184) and Yuki (husky) at (204, 185), both facing South (the camera).
#   d. Nelim: BasicShirt dyed emerald (28, 110, 80), Pants dyed brown, Jacket dyed deep blue (28, 48, 96), no hat;
#      hairstyle Ponytails, near-black brown; expression: awe, MouthSmile and BrowRaised.
#   e. action: she carries the item "MealSimple", the dogs' supper, her head turned to the rocket (facing North).
#   f. zoom 7 on (199, 189), 25 x 14 cells; the rocket two or three cells up its climb with its purple trails and sparks, the stand
#      at the bottom centre, Nelim at the left from behind, the two dogs low right facing us, the grass in the foreground; dusk light.
#   g. subject: the rocket leaving. "It leaves, and supper is forgotten."
#   h. risk: caught before the rocket leaves or after the trails (two earlier runs). Plan: the camera is framed before the salvo, the
#      shutter is the light + 25 ticks on the stand's clock, the game is paused first; a step that fails to find the light fails
#      the scenario instead of shooting an empty sky.
#   i. not a plate: the stand, the dogs and the grass at three depths.   j. the mod: the rocket, its trails, the departure.
#   subtitle: "The rocket leaves, and supper is forgotten."
#
#  3 light  (score 4)
#   a. calm-zone, 23h (night), clear, the light + 30 ticks.
#   b. decor: two PlantPot with Plant_Dandelion fully grown at (196, 182) and (203, 182), either side of the stand, lit by it.
#   c. life: Plant_Dandelion; Shogun at (203, 184) and Yuki at (203, 182) facing South, at the edge of the glow.
#   d. Nelim: BasicShirt dyed beige (214, 200, 170), Pants dyed brown, no hat, no parka (NSB canon 2026-10-30: midsummer eve is warm, the parka is not in her profile);
#      hairstyle Roo_HD_Hair_Highpony (canon high ponytail), near-black brown (gene Hair_DarkSaturatedReddish once NPT has a step for it); expression: a soft small smile, MouthLipsSmallSmile,
#      cheeks flushed by the cold (SkinRosyCheeks).
#   e. state: dressed for the warm night, facing East in profile beside the stand, her face lit.
#   f. zoom 4.5 on (199, 184), 16 x 9 cells; the cream square lit warm round the stand, all else dark; the dandelion pots at the two
#      edges of the glow as framing; Nelim left of the stand, the dogs right.
#   g. subject: the light on the ground. "The stand lights the night, it is not a lamp."
#   h. risk: the light is a 240-tick flash and a stray tick loses it; face steps may name a part the game does not know. Plan: the
#      light comes on within 30 seconds is asserted, the shutter is +30 ticks with the game paused; if a face part name fails,
#      the scenario fails with the list of names (read it, use a name from it) and the own face stays.
#   i. not a plate: lit pots, three beings at different distances.   j. the mod: the light the stand throws.
#   subtitle: "The stand lights the whole square, only for a moment."
#
#  4 burst  (score 4)
#   a. calm-zone, 23h, clear, the light + 100 ticks.
#   b. decor: two PlantPot with Plant_Rose fully grown at (198, 186) and (202, 186) in the foreground (a rose is not a daylily or a
#      dandelion; if the def is unknown the scenario fails with the list and Plant_Daylily takes its place).
#   c. life: Plant_Rose; Shogun at (203, 184) and Yuki at (204, 185) facing South, small at the bottom.
#   d. Nelim: Jacket dyed emerald (30, 100, 70) over BasicShirt dyed beige and Pants dyed brown; no hat;
#      hairstyle Ponytails, near-black brown; expression: wonder, MouthSmile, BrowRaised (a small figure, read by her stance).
#   e. state: head turned up (facing North), the jacket open: she watches the burst, the dogs at her feet.
#   f. zoom 8.5 on (200, 190), 30 x 17 cells; the burst high over the flowers and the bamboo (about 12 cells north of the stand), the
#      stele at the right, Nelim and the dogs small at the bottom, the rose pots as foreground.
#   g. subject: the burst. "The show itself, over the bamboo."
#   h. risk: the burst delay read off one picture only (04a, 2026-10-14); the rocket may be still climbing or gone. Plan: the picture is
#      taken at the light + 100 ticks; if it misses, the same scenario is replayed at the light + 85 and + 115 as one small ticket
#      before anything else is judged.
#   i. not a plate.   j. the mod: the burst itself.
#   subtitle: "The show itself, over the bamboo."
#
#  5 reload (score 4, a scene with the inspect pane: no subtitle; the morning after the show)
#   a. calm-zone, 9h (the morning after, low clear light, the pane reads in daylight), clear, 60 ticks after the stand is back to 3.
#   b. decor: Plant_YellowTallGrass fully grown at (194, 183) and (194, 185), Hay at (198, 187).
#   c. life: Plant_YellowTallGrass; no animal (the pane is the subject, the frame stays light).
#   d. Nelim: BasicShirt dyed deep blue (28, 52, 110), Pants dyed beige (200, 184, 150), no hat;
#      hairstyle Ponytails, near-black brown; expression: focused, MouthNormal and BrowSquare (BrowThick does not exist: run 888d).
#   e. action: she carries the item "FireworkLauncher", the next one, at her post by the stand.
#   f. zoom 5 on (198, 184), the interface on but cleaned (colonist bar, resources, alerts, learning helper, tooltips and labels
#      hidden), the inspect pane open on the left; Nelim and the stand in the right two thirds.
#   g. subject: the reload counter. "The stand reloads, one launcher a salvo."
#   h. risk: the hide steps are new and unseen; zone paint or a HUD part may still cover the frame. Plan: the picture is opened
#      first; if anything covers it, the step is described to NPT with the capture and the scene replayed after the answer.
#   i. not a plate.   j. the mod: the inspect pane, the countdown, the launcher.
#
#  6 menu   (interface scene: set aside, not scored; the Architect menu is taken for what it is, no subtitle)
#   12h, the Architect Joy category open on the cleaned interface, the stand listed. No Nelim, no decor. "Where to find it."
#   Risk: the menu did not open on the run of 2026-10-14; plan: windows are allowed to open before the category is opened (done).
#
# Pictures 1 to 4 hide the interface (the game's own screenshot mode) and 5 and 6 show it. ClearScreen keeps a log viewer or a
# notice of another mod out of every frame.
@review @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.clearscreen @requires:nelim.pickletools.clickdiagnostics @requires:nelim.pickletools.colonistrace @requires:nelim.pickletools.stagedecor
Feature: the Workshop gallery, in the Sanctuary's calm zone

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: the screen is clear
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And Nelim's Pickle Tools: the temperature of the map is 22 degrees

  @timeout:180
  Scenario: gallery 1: the fuse smoking, Nelim waiting
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 1 launchers
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (195, 186)
    And Nelim's Pickle Tools: I place the decor "Hay" at (202, 186)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ShirtRuffle" dyed rgb (150, 30, 40)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 64, 40)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (42, 30, 24)
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: an adult animal of kind "LabradorRetriever" named "Shogun" is spawned at (203, 185)
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
    And Nelim's Pickle Tools: the decor is removed
    And no errors were logged

  @timeout:340
  Scenario: gallery 2: the rocket leaving at dusk
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 1 launchers
    And Nelim's Pickle Tools: I place the decor "Hay" at (202, 186)
    And Nelim's Pickle Tools: I place the decor "Hay" at (204, 186)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (195, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (196, 188) fully grown
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (28, 110, 80)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 64, 40)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Jacket" dyed rgb (28, 48, 96)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (42, 30, 24)
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: "Nelim" carries the item "MealSimple"
    And Nelim's Pickle Tools: an adult animal of kind "LabradorRetriever" named "Shogun" is spawned at (203, 184)
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
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowRaised"
    And Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 02: the rocket leaving at dusk"
    And Nelim's Pickle Tools: the decor is removed
    And no errors were logged

  @timeout:340
  Scenario: gallery 3: the ground lit at night as the rocket leaves
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 1 launchers
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Dandelion" fully grown at (196, 182)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Dandelion" fully grown at (203, 181)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (214, 200, 170)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 64, 40)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (42, 30, 24)
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: an adult animal of kind "LabradorRetriever" named "Shogun" is spawned at (203, 184)
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
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmile"
    And Nelim's Pickle Tools: "Nelim" face skin is "SkinRosyCheeks"
    And Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 03: the ground lit at night as the rocket leaves"
    And Nelim's Pickle Tools: the decor is removed
    And no errors were logged

  @timeout:340
  Scenario: gallery 4: the burst at night, over the flowers and the bamboo
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 1 launchers
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (198, 186)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (202, 186)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (214, 200, 170)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 64, 40)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Jacket" dyed rgb (30, 100, 70)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (42, 30, 24)
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: an adult animal of kind "LabradorRetriever" named "Shogun" is spawned at (203, 184)
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
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowRaised"
    And Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 04: the burst at night"
    And Nelim's Pickle Tools: the decor is removed
    And no errors were logged

  @timeout:180 @requires:nelim.pickletools.screenshotmode
  Scenario: gallery 5: the stand counting down its reload, with its inspect pane
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 4 launchers
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (194, 183) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (194, 185) fully grown
    And Nelim's Pickle Tools: I place the decor "Hay" at (198, 187)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (28, 52, 110)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (200, 184, 150)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (42, 30, 24)
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And I set the weather to "Clear"
    And I set the hour to 9
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the painted zones are hidden
    When Nelim's Pickle Tools: I frame the cell (198, 184) at zoom 5
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 comes to hold 3 launchers within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (197, 184) facing East
    And Firework Stand: "Nelim" is told to stay where they stand
    And Nelim's Pickle Tools: "Nelim" carries the item "FireworkLauncher"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowSquare"
    And Nelim's Pickle Tools: windows are allowed to open again
    And Firework Stand: I select the stand at x=200 z=183
    And Nelim's Pickle Tools: I move the mouse to (1500, 400)
    And Nelim's Pickle Tools: I let 60 ticks pass
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And Nelim's Pickle Tools: I let 10 ticks pass
    Then I take a screenshot "gallery 05: the stand counting down its reload"
    And Nelim's Pickle Tools: the decor is removed
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
