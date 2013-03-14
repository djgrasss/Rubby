module Rubby::Nodes
  class Argument < Base
    value :name, ::String

    def to_ruby(runner)
      [ name ]
    end
  end
end
