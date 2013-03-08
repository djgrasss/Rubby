Feature: I should be able to define methods

  Scenario: I define an empty method without any arguments
    When I enter 'my_method ->'
    And I transpile it
    Then I should get 'def my_method; end'
