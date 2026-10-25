# Pickle runs: one text line per run (history; evidence is on disk in Tests/Pickle/Evidence, or deleted)

2026-09-21 english first four features: passed, 8 of 11 played (3 @wip since removed); evidence deleted.
2026-09-21 french, suite of 49c36d8: passed 21 of 21; evidence deleted, suite reshaped.
2026-09-23 english, reshaped suite 0.1.0: passed 26 of 26; evidence deleted 2026-10-20 (older than the code commit 7a59b01).
2026-09-24 english cut short (watchdog-timeout, 5 of 27 played): no proof, deleted.
2026-09-24 without Ideology, whole suite, first attempt: killed as stalled, 5 of 15; cause the fixture (NullReferenceException in Pawn_AgeTracker without Ideology), not the stand; deleted.
2026-09-24 french, reshaped suite 0.1.0: passed 26 of 26; deleted 2026-10-20 (stale).
2026-09-24 english on the 0.1.1 build (c920): failed 26 of 27, a bug of the smoke step, fixed; deleted 2026-10-20 (stale).
2026-09-24 french on the 0.1.1 build (6858): failed 26 of 27, same bug; deleted 2026-10-20 (stale); its UI captures read 2026-10-17, fine.
2026-09-24 without Ideology, feature 12 only (e077): passed 1 of 1, the launch gizmo is offered only without Ideology; deleted 2026-10-20 (stale).
2026-09-24 to 25 smoke runs (8c21, 5241, 374b, 50ce, 189a): puffs not visible on the game's Smoke fleck, then FS_FuseSmoke tuned until 1 of 1 passed with at least 4 puffs at 40 ticks (8b2096f); deleted 2026-10-20 (stale).
2026-09-25 to 27 vitrine runs one to nine (3b3b, 5a79, a79b, f586, e0f0, 6702, ad7c, 2911): 3 of 4 each, the night scenario red; the trace of the ninth named the cause: the light is a flash at the rocket's departure and the launcher was spent when the light went out.
2026-09-28 vitrine tenth (8bb2, tree 7a59b01): 2 of 4, the two failures were consequences of the fix in the scenarios, not defects.
2026-09-28 vitrine eleventh (f46f, tree f5c2f1c): green 4 of 4, the night scenario green for the first time; deleted 2026-10-20.
2026-10-11 vitrine (96e1, eda7447): red 0 of 4, the studio fixture was deleted 2026-10-08; deleted.
2026-10-12 vitrine Sanctuary (809c, 992b): green 4 of 4, refused as gallery images (framing); deleted 2026-10-20.
2026-10-13 vitrine zoom9 (45af) and zoom4 (88de): green 4 of 4 each; zoom 9 did not take, zoom 4 and 7 gave the four candidates now in Art/Gallery; deleted 2026-10-20.
2026-10-14 vitrine Nelim (5a3b): green 5 of 5, the session kept 03 and 04a and refused the rest; deleted 2026-10-20.
2026-10-17 session review of the UI captures (OWNER-CHECKS 3, 4, 5): French empty stand, selected launcher, without-Ideology gizmo and Architect menu all fine.
2026-10-18 db97 vitrine old feature 14: 2 of 6 (1 to 4 kind Labrador unknown; 5 and 6 green, menu opens), evidence trimmed to summary, junit, one screenshot (06); cdbf same feature: staging failed, 3745223213 (eyegenes3) has no About.xml in the Workshop folder, exit 3, no report, refile after the TM fixes the folder.
2026-10-19 d9ef gallery 1 to 5 refile: staging failed, astryl.facialanimationperformancepatch 3790129900 in none of /workshop /workshop-cache /windows-mods, exit 1, no report; Inbox and Evidence emptied (db97 proof of scene 6 deleted, folder summary was the old red run).
2026-09-28 english and french full passes (build 0.1.1, preserved 2026-09-29): english 26 of 31, french 25 of 31, 4 skipped each (old zen-meadow feature 14, superseded). Red in both: feature 09 "the timer, the light and the count survive a save and a reload", "holds 3 launchers, not 2": scenario stale since 0.1.1 (launcher spent when the light goes out), fixed 2026-10-20, to replay. Red in french only: feature 07 "an idle colonist ... watches it standing", colonist took Play_Horseshoes (competing joy, header of the feature warns of it; english green), to replay in french. Both folders deleted 2026-10-20.
2026-09-28 without Ideology (feature 12): passed 1 of 1, kept minified in Evidence with RELEASE.md.
2026-10-19 888d gallery 1 to 5 calm-zone (staging fine this time): 1 of 5. Scene 2 green but picture refused (rocket a thin trail at the top, stand on the bottom edge, Nelim seen from behind). 1, 3, 4 failed "the cell already holds PlantPot" (the decor step refuses a plant on a pot cell; plants now on the ground, pots asked of NPT), 5 failed "No brow type BrowThick" (now BrowSquare). Folder deleted 2026-10-21.
2026-10-23 94cf feature 09 english on 60e8126: passed 1 of 1 ("the timer, the light and the count survive a save and a reload"); 72d6 features 07 and 09 french on 60e8126: passed 4 of 4 (the colonist-took-Play_Horseshoes failure of 2026-09-28 gone). Folders deleted 2026-10-25, proof is this line.
2026-10-23 calm-zone gallery 1, 3, 4, 5 on 70246a7 (pots with plants through StageDecor): green 4 of 4, all pictures opened 2026-10-25. Kept as candidates: 01 (fuse smoke, Nelim in red, Shogun facing), 03 (warm light on the square, Tuque, both dogs), 04 (burst over the bamboo, roses in pots). Refused: 05 (white zone paint rectangles and the HUD still cover the frame: NPT). Scene 2 not in this run (old candidate kept as placeholder). Folder deleted 2026-10-25.
