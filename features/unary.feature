Feature: Unary operations

  Scenario: I use a unary +
    When I enter '+12345'
    And I transpile it
    Then I should get '+12345'

  Scenario: I use a unary -
    When I enter '-12345'
    And I transpile it
    Then I should get '-12345'

  Scenario: I use a unary !
    When I enter '!12345'
    And I transpile it
    Then I should get '!12345'

  Scenario: I use a unary ~
    When I enter '~12345'
    And I transpile it
    Then I should get '~12345'

  Scenario: I use a unary &
    When I enter '&12345'
    And I transpile it
    Then I should get '&12345'

  Scenario: I use a unary ?
    When I enter '?12345'
    And I transpile it
    Then I should get 'defined? 12345'
