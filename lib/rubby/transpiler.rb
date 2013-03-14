module Rubby
  class Transpiler < Runner
    require 'rubby/transpiler/ruby_formatter'

    def process
      RubyFormatter.process(tree.map { |n| n.to_ruby(self) })
    end
  end
end
