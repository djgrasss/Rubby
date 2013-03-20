module Rubby::Nodes
  class ExplicitReturn < Base
    child :content, Base

    def to_ruby(runner)
      [ "return #{inline(content,runner)}" ]
    end
  end
end
