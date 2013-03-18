module Rubby::Nodes
  class ArgumentWithDefault < Argument
    child :default, Base

    def to_ruby(runner)
      [ "#{name}=#{default.to_ruby(runner).first}" ]
    end
  end
end
