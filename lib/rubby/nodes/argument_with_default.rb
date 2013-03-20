module Rubby::Nodes
  class ArgumentWithDefault < Argument
    child :default, Base

    def to_ruby(runner)
      [ "#{name}=#{inline(default,runner)}" ]
    end
  end
end
