Feature: Array literals

  Scenario: empty array literals
    When I enter '[]'
    And I transpile it
    Then I should get '[]'

  Scenario: single-element array literal
    When I enter '[ 1 ]'
    And I transpile it
    Then I should get '[1]'

  Scenario: multi-element array literal
    When I enter '[ 1, :two, 'three', Four, five ]'
    And I transpile it
    Then I should get '[1, :two, 'three', Four, five]'
