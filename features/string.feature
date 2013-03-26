Feature: I like strings.

  Scenario: I use single ticks
    When I enter
    """
    'single ticks, bitches!'
    """
    And I transpile it
    Then I should get
    """
    'single ticks, bitches!'
    """

  Scenario: I use double ticks
    When I enter
    """
    "double ticks, bitches!"
    """
    And I transpile it
    Then I should get
    """
    "double ticks, bitches!"
    """

    @todo
  Scenario: I interpolate some Rubby
    Given I am targetting Ruby 1.8
    When I enter
    """
    "My favourite hash: #{ {foo: 1, bar: 2}.inspect }"
    """
    And I transpile it
    Then I should get
    """
    "My favourite hash: #{ { :foo => 1, :bar => 2 }.inspect }"
    """

  Scenario: I attempt to interpolate some Rubby in a single-tick string
    When I enter
    """
    'My favourite hash: #{ {foo: 1, bar: 2}.inspect }'
    """
    And I transpile it
    Then I should get
    """
    'My favourite hash: #{ {foo: 1, bar: 2}.inspect }'
    """
