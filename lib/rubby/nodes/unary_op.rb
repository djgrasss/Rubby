module Rubby::Nodes
  class UnaryOp < Base
    value :operator, ::String
    child :right, Base

    def to_ruby(runner)
      [ "#{get_operator}#{inline(right,runner)}" ]
    end

    def get_operator
      operator == '?' ? 'defined? ' : operator
    end
  end
end
