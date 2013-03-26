Feature: Symbol literals

  Scenario: Simple symbols
    When I enter ':foo'
    And I transpile it
    Then I should get ':foo'

  Scenario: String symbols
    When I enter ':"foo bar"'
    And I transpile it
    Then I should get ':"foo bar"'

    @todo
  Scenario: String symbols with interpolation
    When I enter ':"foo #{bar}"'
    And I transpile it
    Then I should get ':"foo #{bar}"'
