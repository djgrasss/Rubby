Feature: I should be able to raise exceptions

  Scenario: I call raise.
    When I enter 'o_O "WTF!"'
    And I transpile it
    Then I should get
    """
    raise("WTF!")
    """
