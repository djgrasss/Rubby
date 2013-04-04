Feature: Rescueing exceptions and ensuring execution.

    @todo
  Scenario: I define a method with a rescue.
    When I enter
    """
    failish ->
      o_O "b00m!" if rand >= 0.5
    e <! Exception
      puts e.message
    """
    And I transpile it
    Then I should get
    """
    def failish
      raise "b00m!" if rand >= 0.5
    rescue Exception => e
      puts e.message
    end
    """

    @todo
  Scenario: I define a method with an ensure.
    When I enter
    """
    failish ->
      o_O "b00m!" if rand >= 0.5
    !>
      puts "always, forever."
    """
    And I transpile it
    Then I should get
    """
    def failist
      raise "b00m!" if rand >= 0.5
    ensure
      puts "always, forever."
    end
    """
