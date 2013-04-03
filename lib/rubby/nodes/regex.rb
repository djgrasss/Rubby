module Rubby::Nodes
  class Regex < Value
    def to_ruby(runner)
      [ value ]
    end
  end
end
