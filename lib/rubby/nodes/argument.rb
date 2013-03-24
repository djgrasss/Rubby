module Rubby::Nodes
  class Argument < AbstractArgument
    value :name, ::String

    def to_ruby(runner)
      [ name ]
    end

    def is_keyword?
      false
    end
  end
end
