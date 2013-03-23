require 'rltk/ast'

module Rubby::Nodes
  class Base < RLTK::ASTNode
    def to_ruby(runner)
      if respond_to? :value
        [ value.inspect ]
      else
        raise Rubby::Exceptions::OverrideMePlease, "#{self.class.to_s} doesn't implement #to_ruby"
      end
    end

    def recurse(nodes,runner)
      wrap(nodes).map { |n| to_ruby_or_to_s(n,runner) }
    end

    def inline(nodes,runner,delim='; ')
      wrap(nodes).flatten.map { |n| to_ruby_or_to_s(n,runner) }.join(delim)
    end

    def should_be_inlined?
      return true unless respond_to? :contents
      case contents.size
      when 0
        true
      when 1
        puts "Contents.first is a #{contents.first.class}"
        contents.first.should_be_inlined?
      else
        false
      end
    end

    def walk(child=children)
      if child.is_a? ::Array
        child.each { |c| walk(c) }
      else
        child.walk if child.respond_to? :walk
      end
      true
    end

    private

    def to_ruby_or_to_s(e, runner)
      if e.respond_to? :to_ruby
        e.to_ruby(runner)
      else
        e.to_s
      end
    end

    def wrap(ary)
      if ary.is_a? ::Array
        ary
      else
        [ary]
      end
    end

    def squash_array(ary)
      if ary.first.is_a? ::Array
        squash_array(ary.first)
      else
        ary
      end
    end
  end
end
