module Rubby::Nodes
  class Call < Base
    value :name, ::String
    child :args, [Base]
    child :block, Block

    def to_ruby(runner)
      [ "#{name}" ]
    end
  end
end
