Feature: Float literals

  Scenario: I enter a float literal
    When I enter '123.1234'
    And I transpile it
    Then I should get '123.1234'

  Scenario: I enter a negative float literal (technically a - unary)
    When I enter '-123.1234'
    And I transpile it
    Then I should get '-123.1234'
