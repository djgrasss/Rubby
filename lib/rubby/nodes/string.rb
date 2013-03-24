module Rubby::Nodes
  class String < Base
    def to_ruby(runner)
      [ value ]
    end
  end
end
