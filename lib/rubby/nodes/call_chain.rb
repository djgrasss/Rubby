module Rubby::Nodes
  class CallChain < Base
    child :left, Call
    child :right, Call

    def to_ruby(runner)
      "#{left.to_ruby(runner).first}.#{right.to_ruby(runner).first}"
    end
  end
end
