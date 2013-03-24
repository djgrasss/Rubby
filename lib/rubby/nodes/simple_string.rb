module Rubby::Nodes
  class SimpleString < String
    value :value, ::String

    def to_ruby(runner)
      [ value ]
    end
  end
end
