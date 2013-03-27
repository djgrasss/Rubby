Feature: Block definition

  Scenario: I define an empty block without any arguments on Ruby 1.8
    Given I am targetting Ruby 1.8
    When I enter '&>'
    And I transpile it
    Then I should get 'lambda {}'

  Scenario: I define an empty block without any arguments on Ruby 1.9
    Given I am targetting Ruby 1.9
    When I enter '&>'
    And I transpile it
    Then I should get '-> {}'

  Scenario: I define a block with one argument on Ruby 1.8
    Given I am targetting Ruby 1.8
    When I enter '&> (x)'
    And I transpile it
    Then I should get 'lambda { |x| }'

  Scenario: I define a block with one argument on Ruby 1.9
    Given I am targetting Ruby 1.9
    When I enter '&> (x)'
    And I transpile it
    Then I should get '-> (x) {}'

  Scenario: I define a block with no arguments and an inline expression on Ruby 1.8
    Given I am targetting Ruby 1.8
    When I enter '&> foo'
    And I transpile it
    Then I should get 'lambda { foo }'

  Scenario: I define a block with simple contents and no arguments on Ruby 1.8
    Given I am targetting Ruby 1.8
    When I enter
    """
    &>
      foo
    """
    And I transpile it
    Then I should get
    """
    lambda { foo }
    """

  Scenario: Simple inline block on 1.8
    Given I am targetting Ruby 1.8
    When I enter '&> true'
    And I transpile it
    Then I should get 'lambda { true }'

  Scenario: I define a block with simple contents and no arguments on Ruby 1.9
    Given I am targetting Ruby 1.9
    When I enter
    """
    &>
      foo
    """
    And I transpile it
    Then I should get
    """
    -> { foo }
    """

    @todo
  Scenario: I define multiple splat arguments to a block on 1.8
    Given I am targetting Ruby 1.8
    When I enter '&> (*foo, *bar)'
    And I transpile it
    Then I should get
    """
    lambda do (*__args__)
      __i__, __size__ = 0, __args__.size
      foo, bar = __args__.partition { |a| i += 1; i < __size__ / 2 }
    """
