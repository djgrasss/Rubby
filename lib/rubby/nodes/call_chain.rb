module Rubby::Nodes
  class CallChain < Base
    child :left, Base
    child :right, Call

    def should_be_inlined?
      right.should_be_inlined?
    end

    def to_ruby(runner)
      lhs = inline(left,runner)
      if should_be_inlined?
        puts "I think I should be inlined"
        [ "#{lhs}.#{inline(right, runner)}" ]
      else
        puts "I think I should be outlined"
        rhs = squash_array(recurse(right,runner))
        top = rhs.shift
        rhs.unshift "#{lhs}.#{rhs}"
        rhs
      end
    end
  end
end
