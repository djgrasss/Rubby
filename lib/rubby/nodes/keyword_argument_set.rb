module Rubby::Nodes
  class KeywordArgumentSet < AbstractArgument
    child :contents, [KeywordArgument]

    KW_ARG_SPLAT = '_keyword_args'

    def to_ruby(runner)
      if runner.target.r20?
        return [inline(contents, runner, ', ')]
      else
        return [KW_ARG_SPLAT+'={}']
      end
    end

    def walk (walker, runner)
      # Not calling super as children are too simple
      inject_into_parent(runner)
    end

    private

    def inject_into_parent(runner)
      unless runner.target.r20?
        if parent.is_a? Method
          contents.each do |node|
            name = Call.new(node.name, [])
            name_symbol = Symbol.new(SimpleString.new(node.name))
            fetch_call = Call.new('fetch', [name_symbol, node.default])
            kw_arg_splat = Call.new(KW_ARG_SPLAT, [])
            index = CallChain.new(kw_arg_splat, fetch_call)
            assign = BinaryOp.new("=", name, index)
            assign.parent = parent
            parent.contents ||= []
            parent.contents.push assign
          end
        end
      end
    end
  end
end
