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
      result << "#{name}#{open_paren}#{generate_arguments(runner)}#{close_paren}"
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
    def generate_arguments(runner)
      if concatenate_splats? runner
        concatenate_splat_arguments runner
      else
        generate_standard_arguments runner
      end
    end

    def generate_standard_arguments(runner)
      inline(args, runner, ', ')
    end

    def concatenate_splats? runner
      runner.target.r18? && (args.select { |a| a.is_a? SplatExpression }.size > 1)
    end

    def concatenate_splat_arguments runner
      # Here we make an assumption that the user is trying to splat two or more arrays
      result = []
      args.each do |arg|
        if arg.is_a? SplatExpression
          result << inline(arg.content, runner)
        else
          result << "[#{inline(arg, runner)}]"
        end
      end
      "*(#{result.join(' + ')})"
    end

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
