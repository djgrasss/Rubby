module Rubby::Nodes
  class UnaryOp < Base
    value :operator, ::String
    child :right, Base
  end
end
