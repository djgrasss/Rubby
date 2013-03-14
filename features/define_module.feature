Feature: Module definition

  Scenario: I define an empty module
    When I enter 'module Foo'
    And I transpile it
    Then I should get 'Foo = Module.new'

  Scenario: I define a module with contents
    When I enter
    """
    module Foo
      whatup?->
    """
    And I transpile it
    Then I should get
    """
    module Foo
      def whatup?; end
    end
    """
