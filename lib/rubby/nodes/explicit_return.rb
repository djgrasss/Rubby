module Rubby::Nodes
  class ExplicitReturn < Base
    child :content, Base

    def to_ruby(runner)
      if content
        [ "return #{inline(content,runner)}" ]
      else
        [ "return" ]
      end
    end
  end
end
