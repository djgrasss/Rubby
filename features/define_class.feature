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

  Scenario: I define a class with some methods
    When I enter
    """
    class ThinkingSphinx::Facet
      attr_reader :name, :properties

      initialize -> (@name, @properties)

      filter_type ->
        if use_field?
          :conditions
        else
          :with

      results_from -> (raw)
        raw.inject {} &> (hash, row)
          hash[row[group_column]] = row['@count']
          hash

      _group_column ->
        if properties.any?(&:multi?)
          '@groupby'
        else
          name

      _use_field? ->
        properties.any? &> (property)
          property.type.nil? || property.type == :string
    """
    And I transpile it
    Then I should get
    """
    class ThinkingSphinx::Facet
      attr_reader(:name, :properties)

      def initialize(name, properties)
        @name = name
        @properties = properties
      end

      def filter_type
        if use_field?
          :conditions
        else
          :with
        end
      end

      def results_from(raw)
        raw.inject({}) do |hash, row|
          hash[row[group_column]] = row['@count']
          hash
        end
      end

      private
      def group_column
        if properties.any?(&:multi?)
          '@groupby'
        else
          name
        end
      end

      private
      def use_field?
        properties.any? { |property| property.type.nil? || property.type == :string }
      end

    end
    """
