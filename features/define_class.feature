Feature: Class definition

  Scenario: I define an empty class without a superclass
    When I enter 'class Foo'
    And I transpile it
    Then I should get 'Foo = Class.new'

  Scenario: I define an empty class with a superclass
    When I enter 'class Foo < Bar'
    And I transpile it
    Then I should get 'Foo = Class.new(Bar)'

  Scenario: I define a class with contents
    When I enter
    """
    class Foo
      initialize->
    """
    And I transpile it
    Then I should get
    """
    class Foo
      def initialize; end
    end
    """

  Scenario: I define a class with contents and a superclass
    When I enter
    """
    class Foo < Bar
      initialize ->
    """
    And I transpile it
    Then I should get
    """
    class Foo < Bar
      def initialize; end
    end
    """
