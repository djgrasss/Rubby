module Rubby::Nodes
  class InstanceArgument < Argument

    def walk(*args)
      super
      inject_into_parent
    end

    def to_ruby(runner)
      [ name ]
    end

    private

    def inject_into_parent
      if parent.is_a? Method
        assign = BinaryOp.new("=", InstanceVariable.new("@#{name}"), Call.new(name, []))
        assign.parent = parent
        parent.contents ||= []
        parent.contents.push assign
      end
    end
  end
end
