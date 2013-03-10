module Rubby::Nodes
  class Block < Base
    child :args, [Base]
    child :contents, [Base]
  end
end
