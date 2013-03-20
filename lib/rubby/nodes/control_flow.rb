module Rubby::Nodes
  class ControlFlow < Base
    child :test, Base
    child :contents, [Base]

    def to_ruby(runner)
      if contents.size <= 1
        [ "#{inline(contents,runner)} #{name} #{inline(test,runner)}" ]
      else
        [ "#{name} #{inline(test,runner)}", recurse(contents, runner), 'end' ]
      end
    end

    def name
      self.class.to_s.split('::').last.downcase
    end
  end
end
