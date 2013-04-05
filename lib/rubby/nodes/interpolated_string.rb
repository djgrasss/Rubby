module Rubby::Nodes
  class InterpolatedString < String
    child :contents, [Base]

    def to_ruby(runner)
      inline(contents, runner, '')
    end
  end
end
