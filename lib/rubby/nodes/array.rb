module Rubby::Nodes
  class Array < Base
    child :values, [Base]

    def to_ruby(runner)
     ["[#{inline(values, runner, ', ')}]"]
    end

  end
end
