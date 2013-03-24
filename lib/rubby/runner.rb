module Rubby
  class Runner
    attr_accessor :source

    def initialize(source, target_version=nil)
      self.source = source
      self.target = target_version
    end

    def tokens
      @tokens ||= Rubby::Lexer.lex(source)
    end

    def tree
      @tree ||= tree_constructor
    end

    def process
      raise Rubby::Exceptions::OverrideMePlease, "Subclasses must implement #process."
    end

    def target=(x)
      @target = TargetVersion.new(x.to_s)
    end

    def target
      @target ||= TargetVersion.new
    end

    private

    def tree_constructor
      Rubby::Parser.parse(tokens).each do |node|
        node.walk(node.children, self)
      end
    end
  end
end
