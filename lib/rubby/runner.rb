module Rubby
  class Runner
    attr_accessor :source

    def initialize(source)
      self.source = source
    end

    def tokens
      @tokens ||= Rubby::Lexer.lex(source)
    end

    def tree
      @tree ||= Rubby::Parser.parse(tokens)
    end

    def process
      raise Rubby::Exceptions::OverrideMePlease, "Subclasses must implement #process."
    end
  end
end
