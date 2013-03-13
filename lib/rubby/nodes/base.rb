require 'rltk/ast'

module Rubby::Nodes
  class Base < RLTK::ASTNode
    def to_ruby
      value.inspect if respond_to? :value
    end
  end
end
