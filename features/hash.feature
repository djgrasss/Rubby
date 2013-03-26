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

  Scenario: I create a hash with only symbol keys on Ruby 1.9
    Given I am targetting Ruby 1.9
    When I enter
    """
    foo: 1, bar: 2, baz: 3
    """
    And I transpile it
    Then I should get
    """
    { foo: 1, bar: 2, baz: 3 }
    """

  Scenario: I create a hash with mixed key types on Ruby 1.9
    Given I am targetting Ruby 1.9
    When I enter
    """
    one: 1, 2: 2, "three": 3
    """
    And I transpile it
    Then I should get
    """
    { :one => 1, 2 => 2, "three" => 3 }
    """
