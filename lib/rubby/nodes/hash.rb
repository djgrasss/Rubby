module Rubby::Nodes
  class Hash < Base
    child :contents, [HashElement]
  end
end
