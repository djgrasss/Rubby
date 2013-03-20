module Rubby::Nodes
  class Class < Base
    child :name, Constant
    child :superclass, Base
    child :contents, [Base]

    def to_ruby(runner)
      if contents.any?
        define_class_with_contents(runner)
      else
        define_singleton_class(runner)
      end
    end

    private

    def define_class_with_contents(runner)
      [].tap do |ruby|
        if superclass
          ruby << "class #{inline(name,runner)} < #{inline(superclass,runner)}"
        else
          ruby << "class #{inline(name,runner)}"
        end
        ruby << recurse(contents,runner)
        ruby << "end"
      end
    end

    def define_singleton_class(runner)
      if superclass
        [ "#{inline(name,runner)} = Class.new(#{inline(superclass,runner)})" ]
      else
        [ "#{inline(name,runner)} = Class.new" ]
      end
    end
  end
end
