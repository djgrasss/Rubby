Feature: As an elite hacker, I want to be able to define regular expressions, because I'm awesome.

  Scenario: A simple regular expression with no options
    When I enter '/foo/'
    And I transpile it
    Then I should get '/foo/'

  Scenario: A simple regular expression with an option
    When I enter '/foo/i'
    And I transpile it
    Then I should get '/foo/i'

  Scenario: A simple regular expression with multipl options
    When I enter '/foo/imxo'
    And I transpile it
    Then I should get '/foo/imxo'

    @todo
  Scenario: A regular expression with interpolation
    When I enter '/foo #{bar.all? &> (i) i == 1} 1/o'
    And I transpile it
    Then I should get '/foo #{bar.all? { |i| i == 1 }} 1/o'
