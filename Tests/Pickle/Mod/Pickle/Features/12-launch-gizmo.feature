# TESTING.md, the last line of the translation checks and the reason the mod exists: Fireworks hides its own
# "launch" gizmo when Ideology is active (`if (ModsConfig.IdeologyActive) yield break;` in
# CompLaunchFireworks.CompGetGizmosExtra), so with Ideology the ritual is the only way to see the
# fireworks and a recreation building is worth adding. Without Ideology the gizmo is there.
#
# ONE SCENARIO FOR TWO PASSES, and each asserts the opposite of the other. The step asks the game
# whether Ideology is active and asserts that the gizmo is offered exactly when it is not, so the
# scenario is never skipped and never vacuous: the default pass (every DLC, Ideology included) must
# find no gizmo, and the pass without Ideology (`wsl-deps.sans-ideology.map`, which leaves the DLC out of
# the staged set) must find one. The capture shows the selected launcher's gizmo bar for a person.
#
# NO TICK MAY RUN IN THIS SCENARIO. The first attempt at the pass without Ideology (2026-09-24) died: the
# fixture save's colonists carry Ideology-related state, and without the DLC the game throws a
# NullReferenceException in Pawn_AgeTracker on every tick, so every scenario that ran the clock failed and the
# launcher killed the run. Nothing here waits for ticks, so nothing ticks: the launcher is spawned, read,
# selected and photographed without the clock running. That is why the pass without Ideology plays this one
# feature only (Run-Passes.ps1 names it), the other scenarios being played in full by the two passes with the DLC.
#
# The gizmo's label and tooltip are Fireworks' own keys (`LaunchFirework`, `LaunchFireworkDesc`) that this
# mod translates into French; the capture of the without-Ideology pass, in each language, is where that
# is read.
@review
Feature: the inherited launch gizmo is there exactly when Ideology is not

  Background:
    Given the save "test-colony" is loaded

  Scenario: a launcher on the ground offers its launch gizmo only without Ideology
    Given I spawn a "FireworkLauncher" at (140, 150)
    Then Firework Stand: the launcher at x=140 z=150 offers its launch gizmo exactly when Ideology is inactive
    When I zoom all the way in
    And I move the camera to (140, 150)
    And Firework Stand: I select the "FireworkLauncher" at x=140 z=150
    Then I take a screenshot "the selected launcher and the gizmos it offers"
    And no errors were logged
