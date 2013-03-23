module Rubby::Nodes
  class Hash < Base
    child :contents, [HashElement]

    def to_ruby(runner)
      if contents.size == 0
        [ '{}' ]
      end
    end
  end
end
