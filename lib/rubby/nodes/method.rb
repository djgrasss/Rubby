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
          ruby << "def #{method_name}(#{args.map { |n| n.to_ruby(runner) }.join(', ')})"
        else
          ruby << "def #{method_name}"
        end
        if contents.any?
          ruby << contents.map { |n| n.to_ruby(runner) }
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
      "#{is_class? ? 'self.': ''}#{basic_method_name}"
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
