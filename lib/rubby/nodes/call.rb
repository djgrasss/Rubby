module Rubby::Nodes
  class Call < Base
    value :name, ::String
    child :args, [Base]
    child :block, Block

    def to_ruby(runner)
      if args.size == 0
        [ "#{name}" ]
      else
        [ "#{name}(#{inline(args,runner,', ')})" ]
      end
    end
  end
end
