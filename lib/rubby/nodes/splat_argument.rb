module Rubby::Nodes
  class SplatArgument < Argument
    def to_ruby(runner)
      [ "*#{name}" ]
    end
  end
end
