Feature: Integer literals

  Scenario: I enter a zero
    When I enter '0'
    And I transpile it
    Then I should get '0'

  Scenario: I enter an integer in decimal notation
    When I enter '123456789'
    And I transpile it
    Then I should get '123456789'

  Scenario: I enter an integer in hexidecimal notation
    When I enter '0x1f93d'
    And I transpile it
    Then I should get '129341'

  Scenario: I enter an integer in octal notation
    When I enter '0123456789'
    And I transpile it
    Then I should get '342391'

  Scenario: I enter an integer in binary notation
    When I enter '0b101011001'
    And I transpile it
    Then I should get '345'

  Scenario: I enter a negative integer (technically a - unary)
    When I enter '-987654321'
    And I transpile it
    Then I should get '-987654321'
