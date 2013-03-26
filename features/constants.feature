Feature: Constant literals

  Scenario: Simple constants
    When I enter 'Foo'
    And I transpile it
    Then I should get 'Foo'

  Scenario: Nested constants
    When I enter 'Foo::Bar'
    And I transpile it
    Then I should get 'Foo::Bar'

  Scenario: all-caps contants
    When I enter 'FOO'
    And I transpile it
    Then I should get 'FOO'

  Scenario: absolute constants
    When I enter '::Foo'
    And I transpile it
    Then I should get '::Foo'

  Scenario: nested absolute constants
    When I enter '::Foo::Bar'
    And I transpile it
    Then I should get '::Foo::Bar'
