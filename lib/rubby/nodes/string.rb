module Rubby::Nodes
  class String < Base
    def to_ruby(runner)
      if value =~ /\'|[:control:]/
        value.inspect
      else
        "'#{value}'"
      end
    end
  end
end
