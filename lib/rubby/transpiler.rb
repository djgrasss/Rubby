module Rubby
  class Transpiler
    require 'rubby/transpiler/ruby_formatter'
    attr_accessor :source
    attr_accessor :filename

    def initialize(source, filename='STDIN', target_version=nil)
      self.source = source
      self.filename = filename
      self.target = target_version
    end

    def tree
      @tree ||= parse_and_modify_source(source)
    end

    def process
      RubyFormatter.process(tree.map { |n| n.to_ruby(self) })
    end

    def target=(x)
      @target = TargetVersion.new(x.to_s)
    end

    def target
      @target ||= TargetVersion.new
    end

    private

    def parse_and_modify_source(source)
      modify_ast parse_source(source).ast
    end

    def parse_source(source)
      Rubby::Parser.new(source).tap { |p| p.parse }
    end

    def modify_ast(ast)
      ast.each do |node|
        node.walk(node.children, self)
      end
    end
  end
end
