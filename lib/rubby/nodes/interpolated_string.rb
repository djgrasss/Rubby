module Rubby::Nodes
  class InterpolatedString < String
    child :contents, [Base]
  end
end
