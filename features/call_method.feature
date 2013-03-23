Feature: I should be able to call methods.

  Scenario: I call a method and pass a block.
    When I enter 'foo &> bar'
    And I transpile it
    Then I should get 'foo { bar }'

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
    Then I should get 'foo.bar { 1 }'

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
    foo.bar do |poping,hats|
      if poping
        puts 'hats are' + hats
      else
        puts 'there are other hats'
      end
    end
    """
