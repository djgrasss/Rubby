Feature: As a professional Rubby programmer, I want to perform an arithmetic operation on the result of two expressions in order to find out the result.

  Scenario: Addition
    When I enter '1 + 1'
    And I transpile it
    Then I should get '1 + 1'

  Scenario: Subtraction
    When I enter '1 - 1'
    And I transpile it
    Then I should get '1 - 1'

  Scenario: Multiplication
    When I enter '1 * 1'
    And I transpile it
    Then I should get '1 * 1'

  Scenario: Division
    When I enter '1 / 1'
    And I transpile it
    Then I should get '1 / 1'

  Scenario: Exponentiation
    When I enter '1 ** 1'
    And I transpile it
    Then I should get '1 ** 1'

  Scenario: Modulo
    When I enter '1 % 1'
    And I transpile it
    Then I should get '1 % 1'

