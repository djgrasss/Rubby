module Rubby::Nodes
  class HashElement < Base
    child :key, Base
    child :value, Base
  end
end
