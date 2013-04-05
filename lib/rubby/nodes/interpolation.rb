module Rubby::Nodes
  class Interpolation < Base
    child :content, Base

    def to_ruby(runner)
      [  '#{' + inline(content, runner) + '}' ]
    end
  end
end
