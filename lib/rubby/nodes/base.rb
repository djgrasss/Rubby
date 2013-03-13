require 'rltk/ast'

module Rubby::Nodes
  class Base < RLTK::ASTNode
    def to_ruby
      value.to_s if respond_to? :value
    end
  end
end
