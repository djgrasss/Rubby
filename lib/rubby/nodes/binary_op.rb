module Rubby::Nodes
  class BinaryOp < Base
    value :operator, ::String
    child :left, Base
    child :right, Base
  end
end
