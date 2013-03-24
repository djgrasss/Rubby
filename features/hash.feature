Feature: we might want a hash or something

  Scenario: I create an empty hash
    When I enter '{}'
    And I transpile it
    Then I should get '{}'

  Scenario: I create a simple hash with a symbol on Ruby 1.8
    Given I am targetting Ruby 1.8
    When I enter
    """
    foo: 1
    """
    And I transpile it
    Then I should get
    """
    { :foo => 1 }
    """

  Scenario: I create a simple hash with a symbol on Ruby 1.9
    Given I am targetting Ruby 1.9
    When I enter
    """
    foo: 1
    """
    And I transpile it
    Then I should get
    """
    { foo: 1 }
    """
