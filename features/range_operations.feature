Feature: As a professional Rubby programmer, I want to have a range operator like all the cool Ruby kids.

  Scenario: inclusive range
    When I enter '1 .. 1'
    And I transpile it
    Then I should get '1 .. 1'

  Scenario: exclusive range
    When I enter '1 ... 1'
    And I transpile it
    Then I should get '1 ... 1'
