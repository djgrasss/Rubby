require 'rltk/parser'

module Rubby
  class Parser < RLTK::Parser
    include ::Rubby::Nodes

    production(:expression) do
      clause('integer')                  { |e| e }
      clause('float')                    { |e| e }
      clause('string')                   { |e| e }
      clause('constant')                 { |e| e }
      clause('symbol')                   { |e| e }
      clause('hash')                     { |e| e }
      clause('array')                    { |e| e }
      clause('call')                     { |e| e }
    end

    production(:constant) do
      clause('WHITE? CONSTANT WHITE?') { |_,e,_| Constant.new(e) }
    end

    production(:integer) do
      clause('WHITE? INTEGER WHITE?')    { |_,e,_| Integer.new(e) }
    end

    production(:float) do
      clause('WHITE? FLOAT WHITE?')  { |_,e,_| Float.new(e) }
    end

    production(:expression_list) do
      clause('') { [] }
      clause('expression') { |e| [e] }
      clause('expression_list WHITE? COMMA WHITE? expression') { |e0,_,_,_,e1| e0 + [e1] }
    end

    production(:interpolation) do
      clause('INTERPOLATESTART WHITE? expression WHITE? INTERPOLATEEND') { |_,_,e,_,_| Interpolation.new(e) }
    end

    production(:simple_string) do
      clause('STRING')                   { |e| SimpleString.new(e) }
      clause('string STRING')            { |e0,e1| e0.tap { |s| s.value += e1 } }
    end

    production(:interpolated_string) do
      clause('simple_string interpolation simple_string') { |e0,e1,e2| InterpolatedString.new([e0,e1,e2]) }
    end

    production(:string) do
      clause('simple_string') { |e| e }
      clause('interpolated_string') { |e| e }
    end

    production(:array) do
      clause('LSQUARE WHITE? expression_list WHITE? RSQUARE') { |_,_,e,_,_| Array.new(e) }
    end

    production(:hash_element) do
      clause('IDENTIFIER WHITE? COLON WHITE? expression') { |e0,_,_,_,e1| HashElement.new(Symbol.new(SimpleString.new(e0)),e1) }
      clause('expression WHITE? COLON WHITE? expression') { |e0,_,_,_,e1| HashElement.new(e0,e1) }
    end

    production(:hash_element_list) do
      clause('hash_element') { |e| [e] }
      #clause('hash_element_list WHITE? COMMA WHITE? hash_element') { |e0,_,_,_,e1| e0 + [e1] }
    end

    production(:hash) do
      clause('hash_element_list') { |e| Hash.new(e) }
    end

    production(:symbol) do
      clause('COLON IDENTIFIER') { |_,e| Symbol.new(SimpleString.new(e)) }
      clause('COLON CONSTANT') { |_,e| Symbol.new(SimpleString.new(e)) }
      clause('COLON string')     { |_,e| Symbol.new(e) }
    end

    production(:expression_group) do
      clause('LPAREN WHITE? expression_list WHITE? RPAREN') { |_,_,e,_,_| e }
    end

    production(:call_without_block) do
      clause('IDENTIFIER') { |n| Call.new(n,[]) }
      clause('IDENTIFIER WHITE? expression_group') { |n,_,e| Call.new(n,e) }
      clause('IDENTIFIER WHITE? expression_list') { |n,_,e| Call.new(n,e) }
    end

    production(:block_without_contents) do
      clause('BLOCK') { |_| Block.new([],[]) }
      clause('BLOCK WHITE? expression_group') { |_,_,e| Block.new(e,[]) }
    end

    production(:block) do
      clause('block_without_contents') { |e| e }
      # clause('block_without_contents WHITE expression') { |e0,_,e1| e0.tap { |b| b.contents = [e1] } }
    end

    production(:call) do
      clause('call_without_block') { |e| e }
      clause('call_without_block WHITE block') { |e0,_,e1| e0.tap { |c| c.block = e1 }}
    end

    finalize explain: true, lookahead: true
  end
end
