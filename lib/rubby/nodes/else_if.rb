module Rubby::Nodes
  class ElseIf < ControlFlow
    def should_prefix?
      false
    end

    def name
      'elsif'
    end
  end
end
