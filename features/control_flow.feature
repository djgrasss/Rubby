Feature: control flow

  Scenario: postfix if
    When I enter 'true if 1'
    And I transpile it
    Then I should get 'true if 1'

  Scenario: posfix unless
    When I enter 'true unless 1 == 2'
    And I transpile it
    Then I should get 'true unless 1 == 2'

  Scenario: if with one expression indented
    When I enter
    """
    if this_is_true
      puts "it was true!"
    """
    And I transpile it
    Then I should get
    """
    puts("it was true!") if this_is_true
    """

  Scenario: if with more than one indented expression
    When I enter
    """
    if this_is_true
      the_thing_was true
      puts "it was true!"
    """
    And I transpile it
    Then I should get
    """
    if this_is_true
      the_thing_was(true)
      puts("it was true!")
    end
    """
