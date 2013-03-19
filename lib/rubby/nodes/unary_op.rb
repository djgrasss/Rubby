module Rubby::Nodes
  class UnaryOp < Base
    value :operator, ::String
    child :right, Base

    def to_ruby(runner)
      [ "#{operator}#{right.to_ruby(runner).first}" ]
    end
  end
end
