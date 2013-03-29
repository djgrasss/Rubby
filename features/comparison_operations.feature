Feature: As a professional Rubby programmer, I want to perform comparison operations on the result of two expressions in order to find out the result.

  Scenario: Less than
    When I enter '1 < 1'
    And I transpile it
    Then I should get '1 < 1'

  Scenario: Greater than
    When I enter '1 > 1'
    And I transpile it
    Then I should get '1 > 1'

  Scenario: Equal
    When I enter '1 == 1'
    And I transpile it
    Then I should get '1 == 1'

  Scenario: Not equal
    When I enter '1 != 1'
    And I transpile it
    Then I should get '1 != 1'

  Scenario: Greater than or equal
    When I enter '1 >= 1'
    And I transpile it
    Then I should get '1 >= 1'

  Scenario: Less than or equal
    When I enter '1 <= 1'
    And I transpile it
    Then I should get '1 <= 1'

  Scenario: Space ship
    When I enter '1 <=> 1'
    And I transpile it
    Then I should get '1 <=> 1'

  Scenario: sort-of equals
    When I enter '1 === 1'
    And I transpile it
    Then I should get '1 === 1'
