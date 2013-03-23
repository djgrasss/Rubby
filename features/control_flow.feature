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
      puts 'it was true!'
    """
    And I transpile it
    Then I should get
    """
    puts('it was true!') if this_is_true
    """

  Scenario: if with more than one indented expression
    When I enter
    """
    if this_is_true
      the_thing_was true
      puts 'it was true!'
    """
    And I transpile it
    Then I should get
    """
    if this_is_true
      the_thing_was(true)
      puts('it was true!')
    end
    """

  Scenario: unless with more than one indented expression
    When I enter
    """
    unless this_is_true
      the_thing_was false
      puts 'it was false!'
    """
    And I transpile it
    Then I should get
    """
    unless this_is_true
      the_thing_was(false)
      puts('it was false!')
    end
    """

  Scenario: if with elsif
    When I enter
    """
    if this_is_true
      puts 'this was true!'
    elsif that_was_true
      puts 'that was true!'
    """
    And I transpile it
    Then I should get
    """
    if this_is_true
      puts('this was true!')
    elsif that_was_true
      puts('that was true!')
    end
    """

  Scenario: if with else
    When I enter
    """
    if this_is_true
      puts 'it was true!'
    else
      puts 'it was false!'
    """
    And I transpile it
    Then I should get
    """
    if this_is_true
      puts('it was true!')
    else
      puts('it was false!')
    end
    """

  Scenario: if with elsif and else
    When I enter
    """
    if thing1_is_true?
      puts 'thing one is true!'
    elsif thing2_is_true?
      puts 'thing two is true!'
    else
      puts 'no things are true :('
    """
    And I transpile it
    Then I should get
    """
    if thing1_is_true?
      puts('thing one is true!')
    elsif thing2_is_true?
      puts('thing two is true!')
    else
      puts('no things are true :(')
    end
    """
