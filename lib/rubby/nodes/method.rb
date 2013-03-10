module Rubby::Nodes
  class Method < Base
    value :name, ::String
    child :args, [Base]
    child :block, Base
  end
end
