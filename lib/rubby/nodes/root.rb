module Rubby::Nodes
  class Root < Base
    child :contents, [Base]
  end
end
