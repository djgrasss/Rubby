module Rubby::Nodes
  class Method < Base
    value :name, ::String
    child :args, [Argument]
    child :contents, [Base]
  end
end
