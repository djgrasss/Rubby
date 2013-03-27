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
      a = inline(args,runner, ', ')
      result << "#{name}#{open_paren}#{a}#{close_paren}"
      if block
        result << " "
        _block = squash_array(recurse(block,runner))
        result << _block.shift
        [result] + _block
      else
        [result]
      end
    end

    private
    def use_parens?
      (args.size > 0) || (block && block.should_be_inlined?)
    end

    def open_paren
      if use_parens?
        '('
      elsif args.size == 0
        ''
      else
        ' '
      end
    end

    def close_paren
      use_parens? ? ')' : ''
    end
  end
end
