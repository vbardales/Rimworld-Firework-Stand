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
# quiet for herself and gives the day to a slow show, one rocket at every beat of the story. She changes once as the day goes: the blood-red party shirt
# of the afternoon, the emerald shirt of dusk and night, then a new day. Her two dogs, SHOGUN the labrador and YUKI the husky, are with her and
# watch her and the show (South, West or North as each beat says, see the plan). No other character, no set: the decor of each picture is
# its own, lived-in, named below, and removed after the shot (`the decor is removed`). EPISODES, in the order of the pictures: 1 late afternoon (16h), she has lit the fuse and waits; 2 dusk (19h), the rocket leaves, supper forgotten; 3 night (23h), the stand lights the square; 4 the same night, a hundred ticks later, the burst; 5 the morning after (9h), she reloads for the next one; 6 the menu that tells the reader where to find it (noon, outside the story). The only light on the night ground is the
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
# between them and the shutter. CANON (SanctuaryBacklot NELIM-PROFIL.md): her hair is a high ponytail (Roo_HD_Hair_Highpony), never a bun; her palette is emerald, deep blue, brown, beige, blood red, gold. HAT RULE (owner, 2026-10-18): a hat only with long loose hair ("Long", never a ponytail or a bun) and a hat-hair mod in the map; no scene wears a hat, so the map holds none (seed removed 2026-11-08). Her garments: the first `wears` undresses her, so every scene dresses her whole: shirt, trousers,
# then the rest.
#
# THE SHOOTING PLAN (rewritten 2026-11-08 against GALLERY.md "Shotlist : critères d'une scène à 4/5", a to g and j, k on the series;
# the interface scene 6 is set aside; director's pass of an Opus sub-agent applied, see the end of this block). Zoom N is the camera's
# half-height (PickleTools docs/GALERIE.md): 2N cells high, about 3.56N wide, a cell is 540 / N px, so a SMALLER N is closer.
# Run 888d (2026-10-21): a plant placed on a PlantPot cell was refused by the plain step; the pot and its plant now go through one NPT step (compiled, not played).
#
# SERIES (criterion k). One story: midsummer eve in the cream square. Nelim gives the day to a slow show, one rocket at each beat of
# the story: lit at 16h, away at 19h, the light at 23h, the burst a hundred ticks later, the reload at 9h the next morning.
# ONE FIXED CORNER in all five pictures, only what the story changes moves: a launch pad of WoodPlankFloor under the stand (so the
# ground is never bare), the Stool at (195, 185), the dogs' Hay at (203, 186) and (204, 187), two PlantPot holding Plant_Daylily at
# (196, 181) and (203, 181) in the foreground, Plant_YellowTallGrass at (195, 187) and (205, 187) behind, two TorchLamp at (195, 183)
# and (205, 183), and the spare rockets, FireworkLauncher at (197, 182), whose pile counts down the night: 4, 3, 2, 2, 1. The torches
# are lit from 19h to 23h and out in 1 (daylight, a torch in the sun looks staged) and in 5 (burnt out, the morning after).
# Variety: 1 and 2 close-medium (zoom 4.5), 5 medium (zoom 5), 3 medium-close (zoom 4.5), 4 wide (zoom 8). Opening image: 1 (the place,
# the stand, the lit fuse). Closing image: 5 (the morning after, the dogs asleep, the reload counter). Rhythm: 16h, 19h, 23h,
# 23h + 100 ticks, 9h, never the same framing twice; Nelim moves along the pad edge from beat to beat.
# Outfits and continuity: 1 she wears the blood-red party shirt to light the fuse; at dusk she changes into the emerald shirt and
# keeps it in 2, 3 and 4 (same evening, no change); 5 is a new day, deep-blue shirt and beige trousers. Hair in every scene:
# Roo_HD_Hair_Highpony (canon high ponytail), gene Hair_DarkSaturatedReddish, no hat. Dogs: Shogun (LabradorRetriever,
# Apparel_leatherdogcollar) and Yuki (Husky, the same collar dyed #FF1493, the fuchsia of NSB). The mod adds no animal. 22 degrees
# on the map: no sweat. Every written smile is a smile; no scene lacks one.
#
#  1. fuse
#   a. calm-zone, 16h, clear, 22 degrees, T + 40 ticks after the fuse is lit (see HOW THE FRAMES ARE MADE TRUE).
#   b. decor: the fixed corner (pad floor "WoodPlankFloor" from (198, 182) to (202, 184), Stool, Hay, 2 pots of Plant_Daylily, grass,
#      the two TorchLamp unlit); 4 FireworkLauncher at (197, 182), the full pile; light: the afternoon sun and the burning fuse.
#   c. life: Plant_Daylily (the midsummer flower); Shogun lying asleep on the hay at (203, 186) facing South (the camera), Yuki at
#      (204, 187) facing West, watching Nelim; collars on.
#   d. Nelim: Apparel_ShirtRuffle dyed rgb (150, 30, 40) blood red and Apparel_Pants dyed rgb (92, 64, 40) brown (the party shirt of
#      the day); Roo_HD_Hair_Highpony; no hat; her own face, the smirk smile and the blink (a pleased smirk, written: a smile).
#   e. action: the WatchStand job, in profile facing East at (196, 184), four cells west of the stand. Instant: she lit the fuse 40
#      ticks ago, the rocket is about to leave. Obtained: she is ordered to watch the stand, then stands at (196, 184) facing East and
#      is told to stay, the game is paused at T + 40.
#   f. zoom 4.5 on (200, 184): the stand at the bottom centre with its thread of smoke, Nelim left of it, the pots as foreground, the dogs
#      on their hay at the right edge, the stool at the left edge; a daylight afternoon, grey smoke on a pale ground.
#   g. subject: the lit fuse. "Nelim has lit the fuse and waits." Readable in the image: smoke over the stand, a full pile of rockets
#      by the pad, one dog asleep and one watching her, a woman in her party shirt waiting.
#   j. the mod: the stand, its fuse and its smoke, large in the frame.
#   subtitle: "Nelim has lit the fuse and waits."
#
#  2. launch
#   a. calm-zone, 19h, clear (dusk, the sky still faintly lit), 22 degrees, the light + 25 ticks.
#   b. decor: the fixed corner with both TorchLamp at (195, 183) and (205, 183) lit (the dusk lamps); 3 FireworkLauncher at (197, 182).
#   c. life: Plant_Daylily, Plant_YellowTallGrass; Shogun at (203, 184) and Yuki at (204, 185) facing West, towards Nelim and her bowl;
#      collars on.
#   d. Nelim: Apparel_BasicShirt dyed rgb (28, 110, 80) emerald and Apparel_Pants dyed rgb (92, 64, 40) (she changed at dusk, the
#      evening shirt); Roo_HD_Hair_Highpony; no hat, no jacket (warm night); awe: MouthSmile and BrowRaised (a smile).
#   e. action: she carries the item Kibble, the dogs' supper, her head turned up to the rocket (facing North). Instant: the rocket has
#      just left, the trails are still lit; supper is forgotten in her hands while the dogs wait for it. Obtained: ordered to watch,
#      then stands at (197, 184) facing North, the item carried, the game paused 25 ticks after the light comes on.
#   f. zoom 5.5 on (199, 185): the rocket two or three cells up its climb, purple trails, the stand and the pad at the bottom centre, Nelim
#      at the left from behind, the dogs low right looking at her, the pots in front, the lamps as two warm points; dusk light.
#   g. subject: the rocket leaving. "The rocket leaves, and supper is forgotten." Readable in the image: a rocket climbing, a woman
#      looking up with a bowl in her hands, two dogs looking at the bowl.
#   j. the mod: the rocket, its trails and the stand's departure light, large in the frame.
#   subtitle: "The rocket leaves, and supper is forgotten."
#
#  3. light
#   a. calm-zone, 23h, clear (night), 22 degrees, the light + 10 ticks.
#   b. decor: the fixed corner with both TorchLamp at (195, 183) and (205, 183) lit; 2 FireworkLauncher at (197, 182).
#   c. life: Plant_Daylily; Shogun at (203, 184) and Yuki at (204, 185) facing South, the camera, collars on, at the edge of the glow.
#   d. Nelim: Apparel_BasicShirt dyed rgb (28, 110, 80) and Apparel_Pants dyed rgb (92, 64, 40), the same as at dusk (same evening);
#      Roo_HD_Hair_Highpony; no hat, no parka (NSB canon: midsummer eve is warm); a soft small smile, her face lit by the stand.
#   e. state: in profile facing East at (197, 185) beside the stand, so that her lit face shows. Instant: the rocket has just left
#      and the flash of the stand fills the square. Obtained: ordered to watch, then stands at (197, 185) facing East, the game paused
#      10 ticks after the light comes on.
#   f. zoom 4.5 on (199, 184): the cream square lit warm round the stand, all else dark; the pots and the two torches at the edges of
#      the glow as framing; Nelim left of the stand, the dogs right.
#   g. subject: the light on the ground. "The stand lights the whole square, only for a moment." Readable in the image: a square lit
#      from one point, a woman and two dogs inside the glow, the rocket gone.
#   j. the mod: the light the stand throws, covering most of the frame.
#   subtitle: "The stand lights the whole square, only for a moment."
#
#  4. burst
#   a. calm-zone, 23h, clear, 22 degrees, the light + 115 ticks.
#   b. decor: the fixed corner with both TorchLamp at (195, 183) and (205, 183) lit, the pots in the foreground at (196, 181) and
#      (203, 181); 2 FireworkLauncher at (197, 182).
#   c. life: Plant_Daylily, Plant_YellowTallGrass; Shogun at (203, 184) and Yuki at (204, 185) facing North with Nelim, collars on,
#      small at the bottom.
#   d. Nelim: Apparel_BasicShirt dyed rgb (28, 110, 80) and Apparel_Pants dyed rgb (92, 64, 40), the same as in 2 and 3; Roo_HD_Hair_Highpony;
#      no hat; wonder: MouthSmile and BrowRaised (a smile, read by her stance).
#   e. state: head thrown back, facing North at (197, 185), the dogs at her side looking up too. Instant: the burst has just opened
#      over the bamboo. Obtained: ordered to watch, then stands at (197, 185) facing North, the game paused 115 ticks after the light.
#   f. zoom 8.5 on (199, 191): the burst high over the flowers and the bamboo, the stele at the right, Nelim and the dogs small at the
#      bottom, the pots and the lamps as foreground.
#   g. subject: the burst. "The show itself, over the bamboo." Readable in the image: a firework flowering over a small group watching.
#   j. the mod: the burst itself, the largest thing in the frame.
#   subtitle: "The show itself, over the bamboo."
#
#  5. reload (a scene with the inspect pane, no subtitle: the morning after the show)
#   a. calm-zone, 9h (the morning after, low clear light), clear, 22 degrees, 60 ticks after the stand is back to 3 launchers.
#   b. decor: the fixed corner with both TorchLamp at (195, 183) and (205, 183) out (burnt out in the night), a Brazier at (204, 184),
#      lit (the morning tea), 1 item Kibble at (196, 186) (the leftover supper), 1 FireworkLauncher at (197, 182), the last of the pile.
#   c. life: Plant_Daylily, Plant_YellowTallGrass; Shogun lying asleep at (203, 186) facing South and Yuki lying asleep at (204, 187)
#      facing South, on their hay, collars on (worn out by the night).
#   d. Nelim: Apparel_BasicShirt dyed rgb (28, 52, 110) deep blue and Apparel_Pants dyed rgb (200, 184, 150) beige (a new day, a new
#      outfit); Roo_HD_Hair_Highpony; no hat; a small satisfied smile, MouthLipsSmallSmile, and BrowSquare (focused: she counts).
#   e. action: she carries the item FireworkLauncher, the next one, at her post by the stand. Instant: the stand has just reloaded
#      to 3, the next rocket is in her hands. Obtained: ordered to watch the stand until it holds 3 launchers, then stands at (197, 184)
#      facing East with the item carried, the pane opened on the stand, the game running only for the shutter.
#   f. zoom 5 on (196, 184): the interface cleaned (colonist bar, resources, alerts, learning helper, tooltips, labels and zone paint
#      hidden), the inspect pane open on the left; Nelim and the stand right of the pane, the sleeping dogs at the right edge.
#   g. subject: the reload counter. "The stand reloads, one launcher a salvo." Readable in the image: a pane that counts the reload,
#      a woman bringing the next rocket, two dogs asleep after the show.
#   j. the mod: the inspect pane with its countdown, the stand and the launcher.
#
#  6. menu   (interface scene: set aside, not scored; the Architect menu is taken for what it is, no subtitle)
#   12h, the Architect Joy category open on the cleaned interface, the stand listed. No Nelim, no decor. "Where to find it."
#   Risk: the menu did not open on the run of 2026-10-14; plan: windows are allowed to open before the category is opened (done).
#
# DIRECTOR'S PASS (Opus sub-agent, one call, 2026-11-08). Kept: one fixed corner and the countdown of the spare pile (series 1, 2);
# Nelim's cell moves along the pad edge (series 3); torch unlit at 16h (scene 1); a sleeping dog and a watching dog (scene 1);
# Kibble as the supper and dogs turned West to it (scene 2); scenes 3 and 4 share their decor and dog cells; dogs looking North
# with her in scene 4; pots moved to the foreground; reframe of scene 5 clear of the pane; traces of the night in scene 5. Not kept:
# Nelim facing North in scene 3 (her smile and her lit face must show in the picture that is about the light on her square). The
# story gap (rockets fired at 16h and 19h) is closed in THE STORY: a slow show, one rocket at every beat.
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
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (198, 182) to (202, 184)
    And Nelim's Pickle Tools: I place the decor "Stool" at (195, 185)
    And Nelim's Pickle Tools: I place the decor "Hay" at (203, 186)
    And Nelim's Pickle Tools: I place the decor "Hay" at (204, 187)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (196, 181)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (203, 181)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (195, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (205, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (195, 183)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (205, 183)
    And Nelim's Pickle Tools: the building "TorchLamp" at (195, 183) is put out
    And Nelim's Pickle Tools: the building "TorchLamp" at (205, 183) is put out
    And Nelim's Pickle Tools: 4 of the item "FireworkLauncher" are spawned at (197, 182)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ShirtRuffle" dyed rgb (150, 30, 40)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 64, 40)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" has the gene "Hair_DarkSaturatedReddish"
    And Nelim's Pickle Tools: "Nelim" hair colour is taken from its genes
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=196 z=184
    And Nelim's Pickle Tools: an adult animal of kind "LabradorRetriever" named "Shogun" is spawned at (203, 186)
    And Nelim's Pickle Tools: the animal "Shogun" is dressed in "Apparel_leatherdogcollar"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Yuki" is spawned at (204, 187)
    And Nelim's Pickle Tools: the animal "Yuki" is dressed in "Apparel_leatherdogcollar" dyed "#FF1493"
    And Nelim's Pickle Tools: the animal "Shogun" lies at (203, 186) facing South
    And Nelim's Pickle Tools: the animal "Yuki" stands at (204, 187) facing West
    And Firework Stand: "Yuki" is told to stay where they stand
    And I set the weather to "Clear"
    And I set the hour to 16
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the cell (200, 184) at zoom 4.5
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 has fired within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (196, 184) facing East
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
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (198, 182) to (202, 184)
    And Nelim's Pickle Tools: I place the decor "Stool" at (195, 185)
    And Nelim's Pickle Tools: I place the decor "Hay" at (203, 186)
    And Nelim's Pickle Tools: I place the decor "Hay" at (204, 187)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (196, 181)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (203, 181)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (195, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (205, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (195, 183)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (205, 183)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (195, 183) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (205, 183) is lit
    And Nelim's Pickle Tools: 3 of the item "FireworkLauncher" are spawned at (197, 182)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (28, 110, 80)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 64, 40)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" has the gene "Hair_DarkSaturatedReddish"
    And Nelim's Pickle Tools: "Nelim" hair colour is taken from its genes
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: an adult animal of kind "LabradorRetriever" named "Shogun" is spawned at (203, 184)
    And Nelim's Pickle Tools: the animal "Shogun" is dressed in "Apparel_leatherdogcollar"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Yuki" is spawned at (204, 185)
    And Nelim's Pickle Tools: the animal "Yuki" is dressed in "Apparel_leatherdogcollar" dyed "#FF1493"
    And Nelim's Pickle Tools: the animal "Shogun" stands at (203, 184) facing West
    And Nelim's Pickle Tools: the animal "Yuki" stands at (204, 185) facing West
    And Firework Stand: "Shogun" is told to stay where they stand
    And Firework Stand: "Yuki" is told to stay where they stand
    And Nelim's Pickle Tools: "Nelim" carries the item "Kibble"
    And I set the weather to "Clear"
    And I set the hour to 19
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the cell (199, 185) at zoom 5.5
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
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (198, 182) to (202, 184)
    And Nelim's Pickle Tools: I place the decor "Stool" at (195, 185)
    And Nelim's Pickle Tools: I place the decor "Hay" at (203, 186)
    And Nelim's Pickle Tools: I place the decor "Hay" at (204, 187)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (196, 181)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (203, 181)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (195, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (205, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (195, 183)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (205, 183)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (195, 183) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (205, 183) is lit
    And Nelim's Pickle Tools: 2 of the item "FireworkLauncher" are spawned at (197, 182)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (28, 110, 80)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 64, 40)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" has the gene "Hair_DarkSaturatedReddish"
    And Nelim's Pickle Tools: "Nelim" hair colour is taken from its genes
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=185
    And Nelim's Pickle Tools: an adult animal of kind "LabradorRetriever" named "Shogun" is spawned at (203, 184)
    And Nelim's Pickle Tools: the animal "Shogun" is dressed in "Apparel_leatherdogcollar"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Yuki" is spawned at (204, 185)
    And Nelim's Pickle Tools: the animal "Yuki" is dressed in "Apparel_leatherdogcollar" dyed "#FF1493"
    And Nelim's Pickle Tools: the animal "Shogun" stands at (203, 184) facing South
    And Nelim's Pickle Tools: the animal "Yuki" stands at (204, 185) facing South
    And Firework Stand: "Shogun" is told to stay where they stand
    And Firework Stand: "Yuki" is told to stay where they stand
    And I set the weather to "Clear"
    And I set the hour to 23
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the cell (199, 184) at zoom 4.5
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 has fired within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (197, 185) facing East
    And Firework Stand: "Nelim" is told to stay where they stand
    Then Firework Stand: the light of the stand at x=200 z=183 comes on within 30 seconds
    When Nelim's Pickle Tools: I let 10 ticks pass
    And game speed is paused
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmile"
    And Nelim's Pickle Tools: I let 5 frames pass
    Then I take a screenshot "gallery 03: the ground lit at night as the rocket leaves"
    And Nelim's Pickle Tools: the decor is removed
    And no errors were logged

  @timeout:340
  Scenario: gallery 4: the burst at night, over the flowers and the bamboo
    Given a "FS_FireworkStand" is built at (200, 183)
    And Firework Stand: the stand at x=200 z=183 is loaded with 1 launchers
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (198, 182) to (202, 184)
    And Nelim's Pickle Tools: I place the decor "Stool" at (195, 185)
    And Nelim's Pickle Tools: I place the decor "Hay" at (203, 186)
    And Nelim's Pickle Tools: I place the decor "Hay" at (204, 187)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (196, 181)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (203, 181)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (195, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (205, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (195, 183)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (205, 183)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (195, 183) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (205, 183) is lit
    And Nelim's Pickle Tools: 2 of the item "FireworkLauncher" are spawned at (197, 182)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (28, 110, 80)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 64, 40)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" has the gene "Hair_DarkSaturatedReddish"
    And Nelim's Pickle Tools: "Nelim" hair colour is taken from its genes
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=185
    And Nelim's Pickle Tools: an adult animal of kind "LabradorRetriever" named "Shogun" is spawned at (203, 184)
    And Nelim's Pickle Tools: the animal "Shogun" is dressed in "Apparel_leatherdogcollar"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Yuki" is spawned at (204, 185)
    And Nelim's Pickle Tools: the animal "Yuki" is dressed in "Apparel_leatherdogcollar" dyed "#FF1493"
    And Nelim's Pickle Tools: the animal "Shogun" stands at (203, 184) facing North
    And Nelim's Pickle Tools: the animal "Yuki" stands at (204, 185) facing North
    And Firework Stand: "Shogun" is told to stay where they stand
    And Firework Stand: "Yuki" is told to stay where they stand
    And I set the weather to "Clear"
    And I set the hour to 23
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the cell (199, 191) at zoom 8.5
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 has fired within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (197, 185) facing North
    And Firework Stand: "Nelim" is told to stay where they stand
    Then Firework Stand: the light of the stand at x=200 z=183 comes on within 30 seconds
    When Nelim's Pickle Tools: I let 115 ticks pass
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
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (198, 182) to (202, 184)
    And Nelim's Pickle Tools: I place the decor "Stool" at (195, 185)
    And Nelim's Pickle Tools: I place the decor "Hay" at (203, 186)
    And Nelim's Pickle Tools: I place the decor "Hay" at (204, 187)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (196, 181)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (203, 181)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (195, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (205, 187) fully grown
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (195, 183)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (205, 183)
    And Nelim's Pickle Tools: the building "TorchLamp" at (195, 183) is put out
    And Nelim's Pickle Tools: the building "TorchLamp" at (205, 183) is put out
    And Nelim's Pickle Tools: I place the decor "Brazier" at (204, 184)
    And Nelim's Pickle Tools: the decor "Brazier" at (204, 184) is lit
    And Nelim's Pickle Tools: 1 of the item "Kibble" are spawned at (196, 186)
    And Nelim's Pickle Tools: 1 of the item "FireworkLauncher" are spawned at (197, 182)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (28, 52, 110)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (200, 184, 150)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" has the gene "Hair_DarkSaturatedReddish"
    And Nelim's Pickle Tools: "Nelim" hair colour is taken from its genes
    And Firework Stand: "Nelim" is bored
    And Firework Stand: "Nelim" is placed at x=197 z=184
    And Nelim's Pickle Tools: an adult animal of kind "LabradorRetriever" named "Shogun" is spawned at (203, 186)
    And Nelim's Pickle Tools: the animal "Shogun" is dressed in "Apparel_leatherdogcollar"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Yuki" is spawned at (204, 187)
    And Nelim's Pickle Tools: the animal "Yuki" is dressed in "Apparel_leatherdogcollar" dyed "#FF1493"
    And Nelim's Pickle Tools: the animal "Shogun" lies at (203, 186) facing South
    And Nelim's Pickle Tools: the animal "Yuki" lies at (204, 187) facing South
    And I set the weather to "Clear"
    And I set the hour to 9
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the painted zones are hidden
    When Nelim's Pickle Tools: I frame the cell (196, 184) at zoom 5
    And game speed is normal
    And Firework Stand: "Nelim" is ordered to watch the stand at x=200 z=183
    Then Firework Stand: the stand at x=200 z=183 comes to hold 3 launchers within 60 seconds
    When Nelim's Pickle Tools: "Nelim" stands at (197, 184) facing East
    And Firework Stand: "Nelim" is told to stay where they stand
    And Nelim's Pickle Tools: "Nelim" carries the item "FireworkLauncher"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmile"
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
  Scenario: gallery 6: the Architect menu (interface window) lists the stand
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
