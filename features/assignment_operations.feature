Feature: As a professional Rubby programmer, I want to assign the result of an expression to another expression in order to store values.

  Scenario: assign
    When I enter 'foo = 1'
    And I transpile it
    Then I should get 'foo = 1'

  Scenario: plus assign
    When I enter 'foo += 1'
    And I transpile it
    Then I should get 'foo += 1'

  Scenario: minus assign
    When I enter 'foo -= 1'
    And I transpile it
    Then I should get 'foo -= 1'

  Scenario: multiply assign
    When I enter 'foo *= 1'
    And I transpile it
    Then I should get 'foo *= 1'

  Scenario: divide assign
    When I enter 'foo /= 1'
    And I transpile it
    Then I should get 'foo /= 1'

  Scenario: modulo assign
    When I enter 'foo %= 1'
    And I transpile it
    Then I should get 'foo %= 1'

  Scenario: exponential assign
    When I enter 'foo **= 1'
    And I transpile it
    Then I should get 'foo **= 1'
