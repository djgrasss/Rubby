module Rubby::Nodes
  class Unless < ControlFlow
    def should_prefix?
      (contents.size <= 1) && !self.next
    end

    def should_end?
      true
    end
  end
end
