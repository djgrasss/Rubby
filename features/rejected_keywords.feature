Feature: Some of Ruby's keywords should explicitly raise a syntax error because they're not supported in Rubby.

  Scenario: do
    When I enter 'do'
    Then transpilation will raise a SyntaxError

  Scenario: and
    When I enter 'and'
    Then transpilation will raise a SyntaxError

  Scenario: or
    When I enter 'or'
    Then transpilation will raise a SyntaxError

  Scenario: not
    When I enter 'not'
    Then transpilation will raise a SyntaxError

  Scenario: return
    When I enter 'return'
    Then transpilation will raise a SyntaxError

  Scenario: proc
    When I enter 'proc'
    Then transpilation will raise a SyntaxError

  Scenario: lambda
    When I enter 'lambda'
    Then transpilation will raise a SyntaxError

  Scenario: raise
    When I enter 'raise'
    Then transpilation will raise a SyntaxError
