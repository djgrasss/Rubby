$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rubby'

module Helpers
  def disabled(message=nil, &block)
    pending message ? "disabled #{message}" : "disabled examples"
  end
end

module ExampleHelpers
  def tokens_for(source)
    Rubby::Lexer.lex(source)
  end

  def ast_for(source)
    Rubby::Parser.parse(tokens_for(source))
  end
end

RSpec.configure do |c|
  c.extend Helpers
  c.include ExampleHelpers
end
