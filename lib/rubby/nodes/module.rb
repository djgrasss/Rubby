module Rubby::Nodes
  class Module < Base
    child :name, Constant
    child :contents, [Base]

    def to_ruby(runner)
      if contents.any?
        define_module_with_contents(runner)
      else
        define_singleton_module(runner)
      end
    end

    private

    def define_singleton_module(runner)
      ["#{inline(name,runner)} = Module.new"]
    end

    def define_module_with_contents(runner)
      [].tap do |ruby|
        ruby << "module #{inline(name,runner)}"
        ruby << recurse(contents,runner)
        ruby << "end"
      end
    end
  end
end
