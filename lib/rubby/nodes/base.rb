require 'rltk/ast'

module Rubby::Nodes
  class Base < RLTK::ASTNode
    def to_ruby(runner)
      if respond_to? :value
        value.inspect
      else
        raise Rubby::Exceptions::OverrideMePlease, "#{self.class.to_s} doesn't implement #to_ruby"
      end
    end
  end
end
