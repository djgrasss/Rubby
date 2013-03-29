Feature: As a professional Rubby programmer, I want to perform logical operations in order to make better informed decisions about my life.

  Scenario: logical AND
    When I enter '1 && 1'
    And I transpile it
    Then I should get '1 && 1'

  Scenario: logical OR
    When I enter '1 || 1'
    And I transpile it
    Then I should get '1 || 1'

  Scenario: logical NOT
    When I enter '!1'
    And I transpile it
    Then I should get '!1'
