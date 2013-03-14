module Rubby::Nodes
  class Constant < Value
    def to_ruby(runner)
      [ value ]
    end
  end
end
