Feature: As a professional Rubby programmer, I want to do fancy bit twiddling in order to impress my boss/wife/dog.

  Scenario: binary AND
    When I enter '1 & 1'
    And I transpile it
    Then I should get '1 & 1'

  Scenario: binary OR
    When I enter '1 | 1'
    And I transpile it
    Then I should get '1 | 1'

  Scenario: binary XOR
    When I enter '1 ^ 1'
    And I transpile it
    Then I should get '1 ^ 1'

  Scenario: binary ones complement
    When I enter '~1'
    And I transpile it
    Then I should get '~1'

  Scenario: binary left shift
    When I enter '1 << 1'
    And I transpile it
    Then I should get '1 << 1'

  Scenario: binary right shift
    When I enter '1 >> 1'
    And I transpile it
    Then I should get '1 >> 1'
