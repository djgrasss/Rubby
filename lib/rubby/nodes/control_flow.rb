module Rubby::Nodes
  class ControlFlow < Base
    child :test, Base
    child :contents, [Base]
    child :next, ControlFlow

    def to_ruby(runner)
      [].tap do |ruby|
        if should_prefix?
          ruby << "#{inline(contents,runner)} #{name} #{inline(test,runner)}"
        else
          if test
            ruby << "#{name} #{inline(test,runner)}"
          else
            ruby << name
          end
          ruby << recurse(contents, runner)
          ruby << self.next.to_ruby(runner) if self.next
          ruby << 'end' if should_end?
        end
      end
    end

    def name
      self.class.to_s.split('::').last.downcase
    end

    def should_end?
      false
    end
  end
end
