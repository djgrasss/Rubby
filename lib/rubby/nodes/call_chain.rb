module Rubby::Nodes
  class CallChain < Base
    child :left, Base
    child :right, Call

    def to_ruby(runner)
      [  "#{inline(left,runner)}.#{inline(right,runner)}" ]
    end
  end
end
