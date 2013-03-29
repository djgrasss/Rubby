Feature: Comments are a smell, but we should probably support them.

  Scenario: I enter a comment in my code
    When I enter
    """
    # foo
    """
    And I transpile it
    Then I should get
    """
    # foo
    """

  Scenario: I comment some code inline
    When I enter
    """
    module Foo
      # my lovely comment
    """
    And I transpile it
    Then I should get
    """
    module Foo
      # my lovely comment
    end
    """
