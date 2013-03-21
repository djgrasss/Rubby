module Rubby::Nodes
  class If < ControlFlow

    def should_prefix?
      (contents.size <= 1) && !self.next
    end

    def should_end?
      true
    end
  end
end
