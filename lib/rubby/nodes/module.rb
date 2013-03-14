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
      ["#{name.to_ruby(runner).first} = Module.new"]
    end

    def define_module_with_contents(runner)
      [].tap do |ruby|
        ruby << "module #{name.to_ruby(runner).first}"
        ruby << contents.map { |n| n.to_ruby(runner) }
        ruby << "end"
      end
    end
  end
end
