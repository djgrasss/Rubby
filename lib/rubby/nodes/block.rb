module Rubby::Nodes
  class Block < Base
    child :args, [AbstractArgument]
    child :contents, [Base]

    def to_ruby(runner)
      if parent_is_a_call?
        process_to_block(runner)
      elsif runner.target.r18?
        process_to_lambda(runner)
      else
        process_to_stabby_lambda(runner)
      end
    end

    private

    def parent_is_a_call?
      parent && parent.is_a?(Rubby::Nodes::Call)
    end

    def process_to_block(runner,inside_args=true)
      if should_be_inlined?
        process_to_inline_block(runner,inside_args)
      else
        process_to_outline_block(runner,inside_args)
      end
    end

    def process_to_inline_block(runner,inside_args)
      result = [ "{" ]
      result << process_arguments(runner,inside_args) if inside_args
      result << inline(contents,runner)
      result << "}"
      result = result.delete_if { |i| i =~ /^\s*$/ }.compact
      if result.size == 2
        [ '{}' ]
      else
        [ result.join(" ") ]
      end
    end

    def process_to_outline_block(runner,inside_args)
      header = [ 'do' ]
      header << process_arguments(runner,inside_args) if inside_args
      header = header.delete_if { |i| i =~ /^\s*$/ }.compact
      [ header.join(" "), recurse(contents,runner), 'end' ]
    end

    def process_to_lambda(runner)
      ruby = process_to_block(runner)
      ruby[0] = "lambda #{ruby[0]}"
      ruby
    end

    def process_to_stabby_lambda(runner)
      ruby = process_to_block(runner, false)
      if args.size > 0
        # _args = process_arguments(runner,true,["(",")"])
        _args = process_arguments(runner,true,["(",")"])
        ruby[0] = "-> #{_args} #{ruby[0]}"
      else
        ruby[0] = "-> #{ruby[0]}"
      end
      ruby
    end

    def process_arguments(runner,run=true,delim=["|"])
      if run && args.size > 0
        # "#{delim[0]}#{inline(args,runner,', ')}#{delim[-1]}"
        "#{delim[0]}#{inline(args,runner,', ')}#{delim[-1]}"
      else
        " "
      end
    end
  end
end
