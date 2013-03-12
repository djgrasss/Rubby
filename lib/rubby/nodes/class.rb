module Rubby::Nodes
  class Class < Base
    child :name, Constant
    child :super, Base
    child :contents, [Base]
  end
end
