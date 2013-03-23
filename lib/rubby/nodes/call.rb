module Rubby::Nodes
  class Call < Base
    value :name, ::String
    child :args, [Base]
    child :block, Block

    def to_ruby(runner)
      result = []
      if args.size == 0
        result << "#{name}"
      else
        result <<  "#{name}(#{inline(args,runner,', ')})"
      end
      result << recurse(block,runner) if block
      puts "result #{result.inspect}"
      result

    end
  end
end
