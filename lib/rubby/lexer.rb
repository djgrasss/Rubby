require 'rltk/lexer'

module Rubby

  class Lexer < RLTK::Lexer

    def self.lex(*args)
      # compress consecutive string tokens together because it's much more
      # performant to do it here than in the parser.
      super(*args).inject([]) do |result, token|
        if (token.type == :STRING) && result.last && (result.last.type == :STRING)
          result.last.value << token.value
          result
        else
          result << token
        end
      end
    end

    KEYWORDS = %w[ module class if else elsif unless ]

    class Environment < Environment
      attr_accessor :current_indent_level

      POSITIVE_INFINITY = +1.0/0.0
      NEGATIVE_INFINITY = -1.0/0.0

      def indent_token_for(str)
        match = /([\r\n]+)([ \t\f]*)/.match(str)
        newlines     = match[1].split('').group_by { |c| c == "\n" }.values.map(&:size).max || 0
        indent_chars = match[2].size
        raise ::Rubby::Exceptions::Indent, "Screwy indent of #{indent_chars} chars" unless indent_chars % 2 == 0
        self.current_indent_level ||= 0
        new_indent_level = indent_chars / 2
        indent_change = new_indent_level - current_indent_level
        case indent_change
        when 0
          [ :NEWLINE ]
        when 1
          self.current_indent_level = new_indent_level
          [ :INDENT, current_indent_level ]
        when NEGATIVE_INFINITY..-1
          result = (new_indent_level...current_indent_level).to_a.reverse.map do |i|
            [ :OUTDENT, i ]
          end
          result << [ :NEWLINE ] if newlines >= 2
          self.current_indent_level = new_indent_level
          result
        when 2..POSITIVE_INFINITY
          raise ::Rubby::Exceptions::Indent, "Abberrant child indent of #{indent_change}"
        end
      end
    end

    KEYWORDS.each do |keyword|
      rule /#{keyword}/, :default do |e|
        keyword.upcase.to_sym
      end
    end
    rule(/o_O/) { [ :RAISE, 'o_O' ] }

    rule /[a-z_][a-zA-Z0-9_]*/, :default do |e|
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
    rule(/0/, :default) { [ :INTEGER, 0 ] }
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
      [ :STRING, "'" ]
    end
    rule /(\\'|[^'])*/, :simple_string do |e|
      [ :STRING, e ]
    end
    rule /'/, :simple_string do
      pop_state
      [ :STRING, "'" ]
    end

    rule /"/, :default do
      push_state :complex_string
      [ :STRING, "\"" ]
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
    rule /\\"/, :complex_string do |e|
      [ :STRING, '\"' ]
    end
    rule /[^"]/, :complex_string do |e|
      [ :STRING, e ]
    end
    rule /"/, :complex_string do
      pop_state
      [ :STRING, "\"" ]
    end

    rule(/\*\*/) { [ :EXPO, '**' ] }
    rule(/\+/)   { [ :PLUS, "+" ] }
    rule(/-/)    { [ :MINUS, "-" ] }
    rule(/\*/)   { [ :MULTIPLY, "*" ] }
    rule(/\//)   { [ :DEVIDE, "/" ] }
    rule(/%/)    { [ :MODULO, "%" ] }

    rule(/</)    { [ :LT, "<" ] }
    rule(/>/)    { [ :GT, ">" ] }
    %w[ == != > < >= <= <=> === ].each do |op|
      rule(%r|#{op}|) { |e| [ :COMPARISONOP, e ] }
    end

    rule(/=/) { |e| [ :ASSIGNEQ, e ] }
    %w[ \+= -= \*= /= %= \*\*= ].each do |op|
      rule(%r|#{op}|) { |e| [ :ASSIGNMENTOP, e ] }
    end

    rule(/\&/) { |e| [ :AMPER, e ] }
    rule(/\^/) { |e| [ :HAT, e ] }
    %w[ \| << >> ].each do |op|
      rule(%r|#{op}|) { |e| [ :BITWISEOP, e ] }
    end

    rule(/\!/) { |e| [ :BANG, "!" ] }
    rule(/~/)  { |e| [ :TILDE, "~" ] }
    rule(/\?/) { |e| [ :QUESTION, "?" ] }
    %w[ && \|\| ].each do |op|
      rule(%r|#{op}|) { |e| [ :LOGICALOP, e ] }
    end

    %w[ \.\. \.\.\. ].each do |op|
      rule(%r|#{op}|) { |e| [ :RANGEOP, e ] }
    end

    rule(/\./) { [ :DOT, "." ] }
    rule(/::/) { [ :CONSTINDEXOP, '::' ] }
    rule(/\[/) { [ :LSQUARE, "[" ] }
    rule(/\]/) { [ :RSQUARE, "]" ] }
    rule(/\(/) { [ :LPAREN, "(" ] }
    rule(/\)/) { [ :RPAREN, ")" ] }
    rule(/\{/) { [ :LCURLY, "{" ] }
    rule(/\}/) { [ :RCURLY, "}" ] }
    rule(/,/) { [ :COMMA, "," ] }
    rule(/@/) { [ :AT, "@" ] }
    rule(/:/) { [ :COLON, ":" ] }
    rule(/\$/) { [ :DOLLAR, "$" ] }

    rule(/->/) { [ :PROC, '->' ] }
    rule(/\&>/) { [ :BLOCK, '&>' ] }
    rule(/->[ \t\f]*\(/) { [ :PROCWITHARGS, '->' ] }
    rule(/\&>[ \t\f]*\(/) { [ :BLOCKWITHARGS, '&>' ] }
    rule(/<-/) { [ :RETURN, '<-' ] }

    rule /#+\s*/, :default do
      push_state :comment
    end
    rule /[\r\n]+[ \t\f]*/, :comment do |e|
      pop_state
      indent_token_for(e)
    end
    rule /.*/, :comment do |e|
      [ :COMMENT, e ]
    end

    rule /[\r\n]+[ \t\f]*/, :default do |e|
      indent_token_for(e)
    end

    rule /[ \t\f]+/, :default do |e|
      [ :WHITE ]
    end

  end
end
