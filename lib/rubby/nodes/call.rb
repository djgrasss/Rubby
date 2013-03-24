module Rubby::Nodes
  class Call < Base
    value :name, ::String
    child :args, [Base]
    child :block, Block

    def should_be_inlined?
      (block && block.should_be_inlined?) || true
    end

    def to_ruby(runner)
      result = ''
      if args.size == 0
        result << "#{name}"
      else
        result <<  "#{name}(#{inline(args,runner,', ')})"
      end
      if block
        result << " "
        _block = squash_array(recurse(block,runner))
        result << _block.shift
        [result] + _block
      else
        [result]
      end
    end
  end
end
