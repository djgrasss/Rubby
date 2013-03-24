Feature: I like strings.

  Scenario: I use single ticks
    When I enter
    """
    'single ticks, bitches!'
    """
    And I transpile it
    Then I should get
    """
    'single ticks, bitches!'
    """

  Scenario: I use double ticks
    When I enter
    """
    "double ticks, bitches!"
    """
    And I transpile it
    Then I should get
    """
    "double ticks, bitches!"
    """
