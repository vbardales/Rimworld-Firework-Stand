# TESTING.md, "before anything", point 2: the stand is hidden until IEDs is researched. RimWorld does not
# grey out a building whose research is unfinished, it omits it from the Architect menu, so on a fresh
# colony the menu looks empty and nothing is wrong. This is the scenario that asserts both halves of it,
# and the last of the manual checks, so that no manual test is left.
#
# It reads the game's own answer, `Designator_Build.Visible`, on the build designator the stand's category
# holds, which is what the menu draws from. The category is found by its def (`Joy`) and the tab is opened
# through the main tabs root, so nothing names a translated word and it runs in both languages.
#
# The research is set to unfinished by a step, not assumed: the fixture colony's research state was never
# looked at. The category's tab is then opened and captured, for a person to see the entry (or its
# absence) as the player does.
@review
Feature: the stand is in the Architect menu once IEDs is researched, and not before

  Background:
    Given the save "test-colony" is loaded

  Scenario: before the research, the Recreation category does not offer the stand
    Given Firework Stand: the research "IEDs" is unfinished
    Then Firework Stand: the Architect menu hides the stand
    When Firework Stand: I open the Architect category of the stand
    And I wait 30 ticks
    Then I take a screenshot "the recreation category before IEDs: no firework stand"
    And no errors were logged

  Scenario: after the research, the Recreation category offers the stand
    Given research "IEDs" is finished
    Then Firework Stand: the Architect menu lists the stand
    When Firework Stand: I open the Architect category of the stand
    And I wait 30 ticks
    Then I take a screenshot "the recreation category after IEDs: the firework stand"
    And no errors were logged
