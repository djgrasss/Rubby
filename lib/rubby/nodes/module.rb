module Rubby::Nodes
  class Module < Base
    child :name, Constant
    child :contents, [Base]
  end
end
