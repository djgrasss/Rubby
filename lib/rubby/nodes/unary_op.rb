module Rubby::Nodes
  class UnaryOp < Base
    value :operator, ::String
    child :right, Base

    def to_ruby(runner)
      [ "#{operator}#{inline(right,runner)}" ]
    end
  end
end
