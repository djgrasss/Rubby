module Rubby::Nodes
  class Comment < Base
    value :value, ::String

    def to_ruby(runner)
      [ "# #{value}" ]
    end
  end
end
