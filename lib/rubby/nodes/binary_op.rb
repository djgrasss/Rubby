module Rubby::Nodes
  class BinaryOp < Base
    value :operator, ::String
    child :left, Base
    child :right, Base

    def to_ruby(runner)
      [ "#{inline(left,runner)} #{operator} #{inline(right,runner)}" ]
    end
  end
end
