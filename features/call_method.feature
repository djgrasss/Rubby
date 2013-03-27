Feature: I should be able to call methods.

  Scenario: I call a method and pass a block.
    When I enter 'foo &> bar'
    And I transpile it
    Then I should get 'foo() { bar }'

  Scenario: I call a method with arguments and pass a block
    When I enter 'foo(a,b,c) &> bar'
    And I transpile it
    Then I should get 'foo(a, b, c) { bar }'

  Scenario: I call a method with a multi-line block
    When I enter
    """
    foo &>
      bar
      1 + 2
    """
    And I transpile it
    Then I should get
    """
    foo do
      bar
      1 + 2
    end
    """

  Scenario: I call a method on an object
    When I enter 'foo.bar'
    And I transpile it
    Then I should get 'foo.bar'

  Scenario: I call a method on an object passing a simple block
    When I enter 'foo.bar &> 1'
    And I transpile it
    Then I should get 'foo.bar() { 1 }'

    @todo
  Scenario: I call a method on an object passing a more complex block
    When I enter
    """
    foo.bar &> (poping,hats)
      if poping
        puts 'hats are' + hats
      else
        puts 'there are other hats'
    """
    And I transpile it
    Then I should get
    """
    foo.bar do |poping, hats|
      if poping
        puts('hats are' + hats)
      else
        puts('there are other hats')
      end
    end
    """

    @todo
  Scenario: I call a with a binary operation
    When I enter
    """
    puts 'hats are' + hats
    """
    And I transpile it
    Then I should get
    """
    puts("hats are" + hats)
    """

  Scenario: I call a method with no arguments and no braces
    When I enter 'foo'
    And I transpile it
    Then I should get 'foo'

  Scenario: I call a method with no arguments in braces
    When I enter 'foo()'
    And I transpile it
    Then I should get 'foo'

  Scenario: I call a method with a single argument
    When I enter 'foo 1'
    And I transpile it
    Then I should get 'foo(1)'

  Scenario: I call a method with another method as an argument
    When I enter 'foo bar'
    And I transpile it
    Then I should get 'foo(bar)'

  Scenario: I call a method with a single argument in braces
    When I enter 'foo(1)'
    And I transpile it
    Then I should get 'foo(1)'

  Scenario: I call a method with multiple arguments
    When I enter 'foo :bar, :baz'
    And I transpile it
    Then I should get 'foo(:bar, :baz)'

  Scenario: I call a method with a hash argument that has braces
    Given I am targetting Ruby 1.8
    When I enter 'foo { bar: 1, baz: 2 }'
    And I transpile it
    Then I should get 'foo({ :bar => 1, :baz => 2 })'

  Scenario: I call a method with a hash argument that has no braces
    Given I am targetting Ruby 2.0
    When I enter 'foo bar: 1, baz: 2'
    And I transpile it
    Then I should get 'foo({ bar: 1, baz: 2 })'

  Scenario: I call a method with a splat argument without parens
    When I enter 'foo *bar'
    And I transpile it
    Then I should get 'foo(*bar)'

  Scenario: I call a method with a splat argument in parens
    When I enter 'foo(*bar)'
    And I transpile it
    Then I should get 'foo(*bar)'

  Scenario: I call a method with mulitple splat arguments on Ruby 2.0
    Given I am targetting Ruby 2.0
    When I enter 'foo(*bar,*baz)'
    And I transpile it
    Then I should get 'foo(*bar, *baz)'

  Scenario: I call a method with multiple splat arguments in Ruby 1.8
    Given I am targetting Ruby 1.8.7
    When I enter 'foo *bar, *baz'
    And I transpile it
    Then I should get 'foo(*(bar + baz))'

  Scenario: I call a method with multiple splat and plain arguments in Ruby 1.8
    Given I am targetting Ruby 1.8.7
    When I enter 'fruits *apples, banana, *pears'
    And I transpile it
    Then I should get 'fruits(*(apples + [banana] + pears))'

  Scenario: I pass an empty block to a method
    When I enter 'foo &>'
    And I transpile it
    Then I should get 'foo() {}'

  Scenario: I pass an empty block to a method with arguments
    When I enter 'foo 1 &>'
    And I transpile it
    Then I should get 'foo(1) {}'

  Scenario: I index a call result
    When I enter 'foo[1]'
    And I transpile it
    Then I should get 'foo[1]'

  Scenario: I index a call result and index that too
    When I enter 'foo[bar][baz]'
    And I transpile it
    Then I should get 'foo[bar][baz]'

  Scenario: I index a call result with the result of another indexing operation
    When I enter 'foo[bar[baz]]'
    And I transpile it
    Then I should get 'foo[bar[baz]]'
