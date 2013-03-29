Feature: As a professional Rubby developer, I like unary operators, because I implemented them.

  Scenario: unary plus
    When I enter '+1'
    And I transpile it
    Then I should get '+1'

  Scenario: unary minus
    When I enter '-1'
    And I transpile it
    Then I should get '-1'

  Scenario: unary not
    When I enter '!1'
    And I transpile it
    Then I should get '!1'

  Scenario: unary complement
    When I enter '~1'
    And I transpile it
    Then I should get '~1'

  Scenario: unary to proc
    When I enter '&:foo'
    And I transpile it
    Then I should get '&:foo'

  Scenario: defined?
    When I enter '?Foo'
    And I transpile it
    Then I should get 'defined? Foo'
