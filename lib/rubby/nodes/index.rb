module Rubby::Nodes
  class Index < BinaryOp
    def to_ruby(runner)
      [ "#{inline(left, runner)}[#{inline(right,runner)}]" ]
    end
  end
end
