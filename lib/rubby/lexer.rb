require 'rltk/lexer'

module Rubby
  class Lexer < RLTK::Lexer
    rule /([a-z][a-zA-Z0-9_]+[=?!]?)/, :default do |e|
      [ :IDENTIFIER, e ]
    end

    rule /([A-Z][a-zA-Z0-9_]+)/, :default do |e|
      [ :CONSTANT, e ]
    end

    rule /(0[1-9][0-9]*)/, :default do |e|
      [ :INTEGER, e.to_i(8) ]
    end
    rule /([1-9][0-9]*)/, :default do |e|
      [ :INTEGER, e.to_i ]
    end
    rule /(0x[0-9a-fA-F]+)/, :default do |e|
      [ :INTEGER, e.to_i(16) ]
    end
    rule /(0b[01]+)/, :default do |e|
      [ :INTEGER, e.to_i(2) ]
    end

    rule /([0-9]+\.[0-9]+)/, :default do |e|
      [ :FLOAT, e.to_f ]
    end

    rule /'/, :default do
      push_state :simple_string
    end
    rule /(\\'|[^'])*/, :simple_string do |e|
      [ :STRING, e.gsub(/\\'/, "'") ]
    end
    rule /'/, :simple_string do
      pop_state
    end

    rule /"/, :default do
      push_state :complex_string
    end
    rule /\#{/, :complex_string do
      push_state :default
      set_flag :inside_complex_string
      [ :STRING_CONCAT ]
    end
    rule /}/, :default, [:inside_complex_string] do
      pop_state
      unset_flag :inside_complex_string
      [ :STRING_CONCAT ]
    end
    rule /(\\"|[^"(\#{)])*/, :complex_string do |e|
      [ :STRING, e.gsub(/\\"/, '"') ]
    end
    rule /"/, :complex_string do
      pop_state
    end

    %w[ \+ - \* / % \*\* ].each do |op|
      rule(%r|#{op}|) { |e| [ :ARITHMETIC_OP, e ] }
    end

    %w[ == != > < >= <= <=> === ].each do |op|
      rule(%r|#{op}|) { |e| [ :COMPARISON_OP, e ] }
    end

    %w[ = \+= -= \*= /= %= \*\*= ].each do |op|
      rule(%r|#{op}|) { |e| [ :ASSIGNMENT_OP, e ] }
    end

    %w[ \& \| \^ ~ << >> ].each do |op|
      rule(%r|#{op}|) { |e| [ :BITWISE_OP, e ] }
    end

    %w[ && \|\| \! ].each do |op|
      rule(%r|#{op}|) { |e| [ :LOGICAL_OP, e ] }
    end

    %w[ \.\. \.\.\. ].each do |op|
      rule(%r|#{op}|) { |e| [ :RANGE_OP, e ] }
    end

    rule(/\./) { [ :DOT, '.' ] }
    rule(/::/) { [ :CONST_INDEX_OP, '::' ] }
    rule(/\?\?/) { [ :DEFINED_OP, '??' ] }
    rule(/\[/) { [ :LSQUARE, '[' ] }
    rule(/\]/) { [ :RSQUARE, ']' ] }

    rule /#+\s*/, :default do
      push_state :comment
    end
    rule /\n/, :comment do
      pop_state
    end
    rule /.*/, :comment do |e|
      [ :COMMENT, e ]
    end
  end
end
