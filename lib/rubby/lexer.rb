require 'rltk/lexer'

module Rubby
  class Lexer < RLTK::Lexer
    KEYWORDS = %w[ module class ]

    class Environment < Environment
      attr_accessor :current_indent_level


      def indent_token_for(indent_chars)
        raise ::Rubby::Exceptions::Indent, "Screwy indent of #{indent_chars} chars" unless indent_chars % 2 == 0
        self.current_indent_level ||= 0
        new_indent_level = indent_chars / 2
        indent_change = new_indent_level - current_indent_level
        case indent_change
        when 0
          return
        when 1
          self.current_indent_level = new_indent_level
          [ :INDENT, current_indent_level ]
        when -Float::INFINITY..-1
          self.current_indent_level = new_indent_level
          [ :DEDENT, current_indent_level ]
        when 2..Float::INFINITY
          raise ::Rubby::Exceptions::Indent, "Abberrant child indent of #{indent_change}"
        end
      end
    end

    KEYWORDS.each do |keyword|
      rule /#{keyword}/, :default do |e|
        keyword.upcase.to_sym
      end
    end

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
      [ :STRING, '' ]
    end
    rule /(\\'|[^'])*/, :simple_string do |e|
      [ :STRING, e.gsub(/\\'/, "'") ]
    end
    rule /'/, :simple_string do
      pop_state
      [ :STRING, '' ]
    end

    rule /"/, :default do
      push_state :complex_string
      [ :STRING, '' ]
    end
    rule /\#\{/, :complex_string do
      push_state :default
      set_flag :inside_complex_string
      [ :INTERPOLATESTART ]
    end
    rule /\}/, :default, [:inside_complex_string] do
      pop_state
      unset_flag :inside_complex_string
      [ :INTERPOLATEEND ]
    end
    rule /(\\"|[^"(\#{)])*/, :complex_string do |e|
      [ :STRING, e.gsub(/\\"/, '"') ]
    end
    rule /"/, :complex_string do
      pop_state
      [ :STRING, '' ]
    end

    rule(/\*\*/) { [ :EXPO, '**' ] }
    rule(/\+/)   { [ :PLUS, '+' ] }
    rule(/-/)    { [ :MINUS, '-' ] }
    rule(/\*/)   { [ :MULTIPLY, '*' ] }
    rule(/\//)   { [ :DEVIDE, '/' ] }
    rule(/%/)    { [ :MODULO, '%' ] }

    %w[ == != > < >= <= <=> === ].each do |op|
      rule(%r|#{op}|) { |e| [ :COMPARISONOP, e ] }
    end

    %w[ = \+= -= \*= /= %= \*\*= ].each do |op|
      rule(%r|#{op}|) { |e| [ :ASSIGNMENTOP, e ] }
    end

    %w[ \& \| \^ << >> ].each do |op|
      rule(%r|#{op}|) { |e| [ :BITWISEOP, e ] }
    end

    rule(/\!/) { |e| [ :BANG, '!' ] }
    rule(/~/) { |e| [ :TILDE, '~' ] }
    %w[ && \|\| ].each do |op|
      rule(%r|#{op}|) { |e| [ :LOGICALOP, e ] }
    end

    %w[ \.\. \.\.\. ].each do |op|
      rule(%r|#{op}|) { |e| [ :RANGEOP, e ] }
    end

    rule(/\./) { [ :DOT, '.' ] }
    rule(/::/) { [ :CONSTINDEXOP, '::' ] }
    rule(/\?\?/) { [ :DEFINEDOP, '??' ] }
    rule(/\[/) { [ :LSQUARE, '[' ] }
    rule(/\]/) { [ :RSQUARE, ']' ] }
    rule(/\(/) { [ :LPAREN, '(' ] }
    rule(/\)/) { [ :RPAREN, ')' ] }
    rule(/\{/) { [ :LCURLY, '{' ] }
    rule(/\}/) { [ :RCURLY, '}' ] }
    rule(/,/) { [ :COMMA, ',' ] }
    rule(/@/) { [ :AT, '@' ] }
    rule(/->/) { [ :PROC, '->' ] }
    rule(/\&>/) { [ :BLOCK, '&>' ] }
    rule(/:/) { [ :COLON, ':' ] }

    rule /#+\s*/, :default do
      push_state :comment
    end
    rule /[\n\r]/, :comment do
      pop_state
      push_state :indenting
      :NEWLINE
    end
    rule /.*/, :comment do |e|
      [ :COMMENT, e ]
    end

    rule /[\r\n]+/, :default do |e|
      push_state :indenting
      :NEWLINE
    end

    rule /[ \t\f]*/, :indenting do |e|
      pop_state
      indent_token_for(e.size)
    end

    rule /[ \t\f]+/, :default do |e|
      [ :WHITE ]
    end

  end
end
