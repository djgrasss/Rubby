module Rubby::Nodes
  class Else < ControlFlow
    def should_prefix?
      false
    end
  end
end
