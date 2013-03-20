module Rubby::Nodes
  class Group < Base
    child :content, Base

    def to_ruby(runner)
      ["(#{inline(content,runner)})"]
    end
  end
end
