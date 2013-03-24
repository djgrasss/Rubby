Feature: Comments are a smell, but we should probably support them.

  Scenario: I enter a comment in my code
    When I enter
    """
    # foo
    """
    And I transpile it
    Then I should get
    """
    # foo
    """
