require 'rubby/version'
require 'rubby/exceptions'
require 'rubby/lexer'
require 'rubby/nodes'
require 'rubby/parser'
require 'rubby/runner'
require 'rubby/target_version'
require 'rubby/transpiler'
require 'rubby/interpreter'
require 'rubby/rubby_loader'

module Rubby
  module_function

  def transpile(source,version=nil)
    Transpiler.new(source, version).process
  end

  def interpret(source, version=nil)
    Interpreter.new(source,version=nil).process
  end
end
