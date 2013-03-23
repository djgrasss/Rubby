module Rubby::Nodes
  class CallChain < Base
    child :left, Base
    child :right, Call

    def should_be_inlined?
      right.should_be_inlined?
    end

    def to_ruby(runner)
      _right = squash_array(recurse(right, runner))
      str = _right.shift
      _right.unshift "#{inline(left,runner)}.#{str}"
      _right
    end
  end
end
