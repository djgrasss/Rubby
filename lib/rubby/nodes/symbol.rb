module Rubby::Nodes
  class Symbol < Base
    child :content, String

    def to_ruby(runner)
      [ ":#{content.value}" ]
    end
  end
end
