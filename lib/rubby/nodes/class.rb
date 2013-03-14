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
          ruby << "class #{name.to_ruby(runner).first} < #{superclass.to_ruby(runner).first}"
        else
          ruby << "class #{name.to_ruby(runner).first}"
        end
        ruby << contents.map { |n| n.to_ruby(runner) }
        ruby << "end"
      end
    end

    def define_singleton_class(runner)
      if superclass
        [ "#{name.to_ruby(runner).first} = Class.new(#{superclass.to_ruby(runner).first})" ]
      else
        [ "#{name.to_ruby(runner).first} = Class.new" ]
      end
    end
  end
end
