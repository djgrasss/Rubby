module Rubby::Nodes
  class KeywordArgument < ArgumentWithDefault

    def to_ruby(runner)
      [ "#{name}: #{default.to_ruby(runner).first}" ]
    end

    def is_keyword?
      true
    end
  end
end
