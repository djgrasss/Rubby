require 'rltk/parser'

module Rubby
  class Parser < RLTK::Parser
    include ::Rubby::Nodes

    right :COLON
    right :EXPO
    right :BANG, :TILDE
    right :MULTIPLY, :DIVIDE, :MODULO
    right :PLUS, :MINUS

    production(:statements) do
      clause('statement')                { |e| [e] }
      clause('statements statement')     { |e0,e1| e0 + [e1] }
    end

    production(:statement) do
      clause('WHITE? expression WHITE? NEWLINE') { |_,e,_,_| e }
      clause('WHITE? expression WHITE?')         { |_,e,_| e }
    end

    production(:expression) do
      clause('class')                    { |e| e }
      clause('module')                   { |e| e }
      clause('integer')                  { |e| e }
      clause('float')                    { |e| e }
      clause('string')                   { |e| e }
      clause('constant')                 { |e| e }
      clause('symbol')                   { |e| e }
      clause('hash')                     { |e| e }
      clause('array')                    { |e| e }
      clause('call')                     { |e| e }
      clause('block')                    { |e| e }
      clause('method')                   { |e| e }
    end

    production(:class_without_contents) do
      clause('CLASS WHITE constant') { |_,_,e| Class.new(e,nil,[]) }
      clause('CLASS WHITE constant WHITE LT WHITE constant') { |_,_,e0,_,_,_,e1| Class.new(e0,e1,[]) }
    end

    production(:class) do
      clause('class_without_contents') { |e| e }
      clause('class_without_contents indented_contents') { |e0,e1| e0.tap { e0.contents = e1 } }
    end

    production(:module_without_contents) do
      clause('MODULE WHITE constant') { |_,_,e| Module.new(e,[]) }
    end

    production(:module) do
      clause('module_without_contents') { |e| e }
      clause('module_without_contents indented_contents') { |e0,e1| e0.tap { |e| e.contents = e1 } }
    end

    production(:constant) do
      clause('CONSTANT') { |e| Constant.new(e) }
    end

    production(:integer) do
      clause('INTEGER')    { |e| Integer.new(e) }
    end

    production(:float) do
      clause('FLOAT')  { |e| Float.new(e) }
    end

    production(:list_sep) do
      clause('WHITE COMMA WHITE') { |_,_,_| }
      clause('WHITE COMMA') { |_,_| }
      clause('COMMA WHITE') { |_,_| }
      clause('COMMA') { |_| }
    end

    production(:expression_list) do
      clause('expression') { |e| [e] }
      clause('expression_list list_sep expression') { |e0,_,e1| e0 + [e1] }
    end

    production(:interpolation) do
      clause('INTERPOLATESTART expression INTERPOLATEEND') { |_,e,_| Interpolation.new(e) }
      clause('INTERPOLATESTART WHITE expression WHITE INTERPOLATEEND') { |_,_,e,_,_| Interpolation.new(e) }
    end

    production(:simple_string) do
      clause('STRING')                   { |e| SimpleString.new(e) }
      clause('simple_string STRING')            { |e0,e1| e0.tap { |s| s.value += e1 } }
    end

    production(:interpolated_string) do
      clause('simple_string interpolation simple_string') { |e0,e1,e2| InterpolatedString.new([e0,e1,e2]) }
    end

    production(:string) do
      clause('simple_string') { |e| e }
      clause('interpolated_string') { |e| e }
    end

    production(:array) do
      clause('LSQUARE RSQUARE') { |_,_| Array.new([]) }
      clause('LSQUARE WHITE RSQUARE') { |_,_,_| Array.new([]) }
      clause('LSQUARE expression_list RSQUARE') { |_,e,_| Array.new(e) }
      clause('LSQUARE WHITE expression_list RSQUARE') { |_,_,e,_| Array.new(e) }
      clause('LSQUARE expression_list WHITE RSQUARE') { |_,e,_,_| Array.new(e) }
      clause('LSQUARE WHITE expression_list WHITE RSQUARE') { |_,_,e,_,_| Array.new(e) }
    end

    production(:hash_sep) do
      clause('COLON WHITE') { |_,_| }
      clause('WHITE COLON WHITE') { |_,_,_| }
    end

    production(:hash_element) do
      clause('IDENTIFIER hash_sep expression') { |e0,_,e1| HashElement.new(Symbol.new(SimpleString.new(e0)),e1) }
      clause('expression hash_sep expression') { |e0,_,e1| HashElement.new(e0,e1) }
    end

    production(:hash_element_list) do
      clause('hash_element') { |e| [e] }
      clause('hash_element_list list_sep hash_element') { |e0,_,e1| e0 + [e1] }
    end

    production(:hash) do
      clause('hash_element_list') { |e| Hash.new(e) }
      clause('LCURLY hash_element_list RCURLY') { |_,e,_| Hash.new(e) }
      clause('LCURLY WHITE hash_element_list WHITE RCURLY') { |_,_,e,_,_| Hash.new(e) }
    end

    production(:any_identifier) do
      clause('IDENTIFIER')           { |e| e }
      clause('IDENTIFIER ASSIGNEQ')  { |e,_| "#{e}=" }
      clause('IDENTIFIER BANG')      { |e,_| "#{e}!" }
      clause('IDENTIFIER QUESTION')  { |e,_| "#{e}?" }
    end

    production(:symbol) do
      clause('COLON any_identifier') { |_,e| Symbol.new(SimpleString.new(e)) }
      clause('COLON CONSTANT') { |_,e| Symbol.new(SimpleString.new(e)) }
      clause('COLON string')     { |_,e| Symbol.new(e) }
    end

    production(:left_paren) do
      clause('LPAREN') { |_| }
      clause('LPAREN WHITE') { |_,_| }
    end

    production(:right_paren) do
      clause('RPAREN') { |_| }
      clause('WHITE RPAREN') { |_,_| }
    end

    production(:expression_group) do
      clause('left_paren right_paren') { |_,_| [] }
      clause('left_paren expression_list right_paren') { |_,e,_| e }
    end

    production(:indented_contents) do
      clause('NEWLINE INDENT statements') { |_,_,e| e }
      clause('NEWLINE INDENT statements DEDENT') { |_,_,e,_| e }
    end

    production(:call_without_arguments) do
      clause('any_identifier') { |e| }
    end

    production(:call_without_block) do
      clause('call_without_arguments') { |e| Call.new(e, []) }
      clause('call_without_arguments expression_list') { |e0,e1| Call.new(e0,e1) }
      clause('call_without_arguments WHITE expression_list') { |e0,_,e1| Call.new(e0,e1) }
      clause('call_without_arguments expression_group') { |e0,e1| Call.new(e0,e1) }
      clause('call_without_arguments WHITE expression_group') { |e0,_,e1| Call.new(e0,e1) }
    end

    production(:block_without_contents) do
      clause('BLOCK') { |_| Block.new([],[]) }
      clause('BLOCK WHITE? arguments') { |_,_,e| Block.new(e,[]) }
    end

    production(:block) do
      clause('block_without_contents') { |e| e }
      clause('block_without_contents WHITE expression') { |e0,_,e1| e0.tap { |b| b.contents = [e1] } }
      clause('block_without_contents indented_contents') { |e0,e1| e0.tap { |b| b.contents = e1 } }
    end

    production(:call) do
      clause('call_without_block') { |e| e }
      clause('call_without_block WHITE block') { |e0,_,e1| e0.tap { |c| c.block = e1 }}
    end

    production('basic_argument') do
      clause('WHITE? IDENTIFIER WHITE?') { |_,e,_| Argument.new(e) }
    end

    production('splat_argument') do
      clause('WHITE? MULTIPLY WHITE? IDENTIFIER WHITE?') { |_,_,_,e,_| SplatArgument.new(e) }
    end

    production('argument_with_defaults') do
      clause('WHITE? IDENTIFIER WHITE? ASSIGNEQ WHITE? expression WHITE?') { |_,e0,_,_,_,e1,_| ArgumentWithDefault.new(e0,e1) }
    end

    production('keyword_argument') do
      clause('WHITE? IDENTIFIER WHITE? COLON WHITE? expression WHITE?') { |_,e0,_,_,_,e1,_| KeywordArgument.new(e0,e1) }
    end

    production(:argument) do
      clause('basic_argument') { |e| e }
      clause('splat_argument') { |e| e }
      clause('argument_with_defaults') { |e| e }
      clause('keyword_argument') { |e| e }
    end

    production(:argument_list) do
      clause('argument')  { |e| [e] }
      clause('argument_list list_sep argument') { |e0,_,e1| e0 + [e1] }
    end

    production(:arguments) do
      clause('left_paren right_paren') { |_,_| [] }
      clause('left_paren argument_list right_paren') { |_,e,_| e }
    end

    production(:method_proc) do
      clause('any_identifier WHITE? PROC') { |e,_,_| Method.new(e,[],[]) }
    end

    production(:method_without_contents) do
      clause('method_proc') { |e| e }
      clause('method_proc WHITE? arguments') { |e0,_,e1| e0.tap { |e| e.args = e1 }}
    end

    production(:method) do
      clause('method_without_contents') { |e| e }
      clause('method_without_contents WHITE expression') { |e0,_,e1| e0.tap { |e| e.contents = [e1] } }
      clause('method_without_contents indented_contents') { |e0,e1| e0.tap { |e| e.contents = e1 } }
    end

    finalize :lookahead => false
  end
end
