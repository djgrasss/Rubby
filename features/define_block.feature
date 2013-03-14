Feature: I should be able to define blocks

  Scenario: I define an empty block without any arguments
    Given I am targetting Ruby 1.8
    When I enter '&>'
    And I transpile it
    Then I should get 'lambda {}'

    Given I am targetting Ruby 1.9
    When I enter '&>'
    And I transpile it
    Then I should get '-> {}'

  @todo
  Scenario: I define a block with one argument on Ruby 1.8
    Given I am targetting Ruby 1.8
    When I enter '&> (x)'
    And I transpile it
    Then I should get 'lambda { |x| }'

  @todo
  Scenario: I define a block with one argument on Ruby 1.9
    Given I am targetting Ruby 1.9
    When I enter '&> (x)'
    And I transpile it
    Then I should get '-> (x) {}'
