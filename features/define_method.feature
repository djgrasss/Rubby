Feature: Method definition

  Scenario: I define an empty method without any arguments
    When I enter 'my_method ->'
    And I transpile it
    Then I should get 'def my_method; end'

  @todo
  Scenario: I define an empty method which takes an argument
    When I enter 'my_method -> (arg1)'
    And I transpile it
    Then I should get 'def my_method(arg1); end'

  Scenario: I define an empty method which takes an argument
    When I enter 'my_method -> (arg1,arg2)'
    And I transpile it
    Then I should get 'def my_method(arg1, arg2); end'

  Scenario: I define an empty method which takes a splat argument
    When I enter 'my_method -> (*args)'
    And I transpile it
    Then I should get 'def my_method(*args); end'

  Scenario: I define an empty method which takes keyword arguments on Ruby 2.0
    Given I am targetting Ruby 2.0
    When I enter 'my_method -> (foo: 1, bar: nil)'
    And I transpile it
    Then I should get 'def my_method(foo: 1, bar: nil); end'

  @todo
  Scenario: I define an empty method which takes keyword arguments on Ruby 1.9
    Given I am targetting Ruby 1.9
    When I enter 'my_method -> (foo: 1, bar: nil)'
    And I transpile it
    Then I should get 'some amazing solution'

  Scenario: I define a method with an inline expression and no arguments
    When I enter 'my_method -> foo'
    And I transpile it
    Then I should get
    """
    def my_method
      foo
    end
    """

  Scenario: I define a method with contents and no arguments
    When I enter
    """
    my_method ->
      foo
    """
    And I transpile it
    Then I should get
    """
    def my_method
      foo
    end
    """
