module Rubby::Nodes
  class Method < Base

    MODIFIERS = /^[@_]{1,2}/

    value :name, ::String
    child :args, [Argument]
    child :contents, [Base]

    def to_ruby(runner)
      [].tap do |ruby|
        ruby << 'private' if is_private? && !is_class?
        if args.any?
          ruby << "def #{method_name}(#{inline(args,runner,', ')})"
        else
          ruby << "def #{method_name}"
        end
        if contents.any?
          ruby << recurse(contents,runner)
          ruby << 'end'
        else
          ruby.last << '; end'
        end
        ruby << "private_class_method :#{basic_method_name}" if is_private? && is_class?
      end
    end

    private
    def is_private?
      modifiers.include? '_'
    end

    def is_class?
      modifiers.include? '@'
    end

    def basic_method_name
      name.gsub(MODIFIERS,'')
    end

    def method_name
      if is_class?
        "self.#{basic_method_name}"
      else
        basic_method_name
      end
    end

    def modifiers
      if match = MODIFIERS.match(name)
        match[0].split('')
      else
        []
      end
    end
  end
end
