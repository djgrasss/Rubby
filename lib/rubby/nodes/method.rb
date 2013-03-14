module Rubby::Nodes
  class Method < Base
    value :name, ::String
    child :args, [Argument]
    child :contents, [Base]

    def to_ruby(runner)
      [].tap do |ruby|
        if args.any?
          ruby << "def #{name}(#{args.map { |n| n.to_ruby(runner) }.join(', ')})"
        else
          ruby << "def #{name}"
        end
        if contents.any?
          ruby << contents.map { |n| n.to_ruby(runner) }
          ruby << 'end'
        else
          ruby.last << '; end'
        end
      end
    end
  end
end
