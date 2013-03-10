require 'rubby/version'
require 'rubby/exceptions'
require 'rubby/lexer'
require 'rubby/nodes'
require 'rubby/parser'
require 'rubby/runner'
require 'rubby/transpiler'
require 'rubby/interpreter'

module Rubby
  module_function

  def transpile(source)
    Transpiler.new(source).process
  end

  def interpret(source)
    Interpreter.new(source).process
  end
end
