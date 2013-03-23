module Rubby::Nodes
  class InstanceVariable < Value
    def to_ruby(runner)
      [ value ]
    end
  end
end
