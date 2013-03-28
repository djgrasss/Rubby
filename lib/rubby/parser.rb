require 'rltk/parser'

module Rubby
  class Parser < RLTK::Parser
    include ::Rubby::Nodes

    def self.parse(tokens, opts={})
      super
    rescue RLTK::NotInLanguage => e
      position = e.token.position
      raise Rubby::Exceptions::SyntaxError,
        "Unexpected token #{e.token.type} at #{position.file_name || "STDIN"}:#{position.line_number} [col #{position.line_offset}]"
    end

    production(:default) do
      clause('statements') { |e| Root.new(e) }
      clause('statements expression') { |e0,e1| Root.new(e0 + [e1]) }
      clause('comment')  { |e| Root.new([e]) }
      clause('expression') { |e| Root.new([e]) }
    end

    production(:statements) do
      clause('statement')                { |e| [e] }
      clause('statements statement')     { |e0,e1| e0 + [e1] }
    end

    production(:statement) do
      clause('NEWLINE') { |_| Swallow.new }
      clause('WHITE? expression WHITE? NEWLINE') { |_,e,_,_| e }
    end

    production(:comment) do
      clause("COMMENT NEWLINE")                  { |e,_| Comment.new(e) }
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
      clause('index')                    { |e| e }
      clause('array')                    { |e| e }
      clause('call')                     { |e| e }
      clause('call_chain')               { |e| e }
      clause('block')                    { |e| e }
      clause('method')                   { |e| e }
      clause('unary_operation')          { |e| e }
      clause('binary_operation')         { |e| e }
      clause('expr_group')               { |e| e }
      clause('explicit_return')          { |e| e }
      clause('control_flow')             { |e| e }
    end

    production(:chainable_expression) do
      clause('integer')                  { |e| e }
      clause('float')                    { |e| e }
      clause('string')                   { |e| e }
      clause('constant')                 { |e| e }
      clause('symbol')                   { |e| e }
      clause('array')                    { |e| e }
      clause('call')                     { |e| e }
      clause('call_chain')               { |e| e }
      clause('block')                    { |e| e }
      clause('expr_group')               { |e| e }
      clause('index')                    { |e| e }
    end

    production(:expr_group) do
      clause('left_paren expression right_paren') { |_,e,_| Group.new(e) }
    end

    production(:index) do
      clause('chainable_expression LSQUARE WHITE? chainable_expression WHITE? RSQUARE') { |e0,_,_,e1,_,_| Index.new('[]', e0, e1) }
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

    nonempty_list(:constant_list, 'CONSTANT', 'CONSTINDEXOP')

    production('constant') do
      clause('constant_list') { |e| Constant.new(e.join('::')) }
      clause('CONSTINDEXOP constant_list') { |_,e| Constant.new("::#{e.join('::')}") }
    end

    production(:integer) do
      clause('INTEGER')    { |e| Integer.new(e) }
    end

    production(:float) do
      clause('FLOAT')  { |e| Float.new(e) }
    end

    production(:list_sep) do
      clause('COMMA WHITE?') { |_,_| }
    end

    production(:expression_list_member) do
      clause('MULTIPLY expression') { |_,e| SplatExpression.new(e) }
      clause('expression')  { |e| e }
    end

    production(:expression_list) do
      clause('expression_list_member') { |e| [e] }
      clause('expression_list list_sep expression_list_member') { |e0,_,e1| e0 + [e1] }
    end

    production(:interpolate_start) do
      clause('INTERPOLATESTART WHITE?') { |_,_| }
    end

    production(:interpolate_end) do
      clause('WHITE? INTERPOLATEEND') { |_,_| }
    end

    production(:interpolation) do
      clause('interpolate_start expression interpolate_end') { |_,e,_| Interpolation.new(e) }
    end

    production(:simple_string) do
      clause('WHITE? STRING')                   { |_,e| SimpleString.new(e) }
      clause('simple_string STRING')     { |e0,e1| e0.tap { |s| s.value += e1 } }
    end

    production(:interpolated_string) do
      clause('simple_string interpolation simple_string') { |e0,e1,e2| InterpolatedString.new([e0,e1,e2]) }
    end

    production(:string) do
      clause('simple_string') { |e| e }
      clause('interpolated_string') { |e| e }
    end

    production(:left_square) do
      clause('LSQUARE WHITE?') { |_,_| }
    end

    production(:right_square) do
      clause('WHITE? RSQUARE') { |_,_| }
    end

    production(:array) do
      clause('left_square right_square') { |_,_| Array.new([]) }
      clause('left_square expression_list right_square') { |_,e,_| Array.new(e) }
    end

    production(:hash_sep) do
      clause('COLON WHITE?') { |_,_| }
    end

    production(:hash_normal_identifier) do
      clause('CONSTANT')         { |e| e }
      clause('IDENTIFIER')       { |e| e }
      clause('COLON IDENTIFIER') { |_,e| e }
    end

    production(:hash_numerical_identifier) do
      clause('integer')          { |e| e }
      clause('float')            { |e| e }
      clause('string')           { |e| e }
    end

    production(:hash_identifier_expression) do
      clause('expr_group') { |e| e }
    end

    production(:hash_element) do
      clause('hash_normal_identifier hash_sep expression') { |e0,_,e1| HashElement.new(Symbol.new(SimpleString.new(e0)),e1) }
      clause('hash_numerical_identifier hash_sep expression') { |e0,_,e1| HashElement.new(e0,e1) }
      clause('hash_identifier_expression hash_sep expression') { |e0,_,e1| HashElement.new(e0,e1) }
    end

    production(:hash_element_list) do
      clause('hash_element') { |e| [e] }
      clause('hash_element_list list_sep hash_element') { |e0,_,e1| e0 + [e1] }
    end

    production(:hash) do
      clause('hash_element_list') { |e| Hash.new(e) }
      clause('LCURLY WHITE? hash_element_list WHITE? RCURLY') { |_,_,e,_,_| Hash.new(e) }
      clause('LCURLY WHITE? RCURLY') { |_,_,_| Hash.new([]) }
    end

    production(:method_identifier) do
      clause('IDENTIFIER')           { |e| e }
      clause('IDENTIFIER ASSIGNEQ')  { |e,_| "#{e}=" }
      clause('IDENTIFIER BANG')      { |e,_| "#{e}!" }
      clause('IDENTIFIER QUESTION')  { |e,_| "#{e}?" }
    end

    production(:symbol_chars) do
      clause('PLUS')       { |e| e }
      clause('MINUS')      { |e| e }
      clause('BANG')       { |e| e }
      clause('HAT')        { |e| e }
      clause('AMPER')      { |e| e }
      clause('MULTIPLY')   { |e| e }
      clause('EXPO')       { |e| e }
      clause('DEVIDE')     { |e| e }
    end

    production(:symbol_identifier) do
      clause('method_identifier') { |e| e }
      clause('CONSTANT')   { |e| e }
    end

    production(:symbol) do
      clause('COLON symbol_chars') { |_,e| Symbol.new(SimpleString.new(e)) }
      clause('COLON symbol_identifier') { |_,e| Symbol.new(SimpleString.new(e)) }
      clause('COLON AT symbol_identifier') { |_,_,e| Symbol.new(SimpleString.new("@" + e)) }
      clause('COLON AT AT symbol_identifier') { |_,_,_,e| Symbol.new(SimpleString.new("@@" + e)) }
      clause('COLON DOLLAR symbol_identifier') { |_,_,e| Symbol.new(SimpleString.new("$" + e)) }
      clause('COLON string')     { |_,e| Symbol.new(e) }
    end

    production(:left_paren) do
      clause('LPAREN WHITE?') { |_,_| }
    end

    production(:right_paren) do
      clause('WHITE? RPAREN') { |_,_| }
    end

    production(:indented_contents) do
      clause('INDENT expression OUTDENT') { |_,e,_| [e] }
      clause('INDENT statements expression OUTDENT') { |_,e0,e1,_| e0 + [e1] }
      clause('INDENT statement expression OUTDENT') { |_,e0,e1,_| [e0] + [e1] }
    end

    production(:call_identifier) do
      clause('method_identifier') { |e| e }
      clause('WTF') { |_| 'raise' }
    end

    production(:call_arguments) do
      clause('WHITE binary_operation') { |_,e| [e] }
      clause('WHITE expression_list') { |_,e| e }
      clause('left_paren expression_list right_paren') { |_,e,_| e }
      clause('left_paren right_paren') { |_,_| [] }
    end

    production(:call_without_block) do
      clause('call_identifier') { |e| Call.new(e, []) }
      clause('call_identifier call_arguments') { |e0,e1| Call.new(e0,e1) }
    end

    production(:block_without_contents) do
      clause('BLOCK') { |_| Block.new([],[]) }
      clause('BLOCKWITHARGS argument_list right_paren') { |_,e,_| Block.new(e,[]) }
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

    production(:call_chain) do
      clause('chainable_expression DOT call') { |e0,_,e1| CallChain.new(e0,e1) }
    end

    production('basic_argument') do
      clause('IDENTIFIER') { |e| Argument.new(e) }
    end

    production('splat_argument') do
      clause('MULTIPLY WHITE? IDENTIFIER') { |_,_,e| SplatArgument.new(e) }
    end

    production('instance_argument') do
      clause('AT IDENTIFIER') { |_,e| InstanceArgument.new(e) }
    end

    production('argument_with_defaults') do
      clause('IDENTIFIER WHITE? ASSIGNEQ WHITE? expression') { |e0,_,_,_,e1| ArgumentWithDefault.new(e0,e1) }
    end

    production('keyword_argument') do
      clause('IDENTIFIER WHITE? COLON WHITE? expression') { |e0,_,_,_,e1| KeywordArgument.new(e0,e1) }
    end

    production(:argument) do
      clause('basic_argument') { |e| e }
      clause('splat_argument') { |e| e }
      clause('instance_argument') { |e| e }
      clause('argument_with_defaults') { |e| e }
      # clause('keyword_argument_list') { |e| e }
    end

    production(:argument_list_intermediate) do
      clause('argument')  { |e| [e] }
      clause('argument_list list_sep argument') { |e0,_,e1| e0 + [e1] }
    end

    production(:argument_list) do
      clause('argument_list_intermediate list_sep keyword_argument_list') { |e0,_,e1| e0 + [e1] }
      clause('keyword_argument_list') { |e0| [e0] }
      clause('argument_list_intermediate') { |e0| e0 }
    end

    production(:keyword_argument_list) do
      clause('keyword_argument') { |e| KeywordArgumentSet.new([e]) }
      clause('keyword_argument_list list_sep keyword_argument') { |e0,_,e1| e0.contents << e1; e0 }
    end

    production(:method_modifier) do
      clause('UNDERSCORE')    { |e| e }
      clause('AT')            { |e| e }
      clause('UNDERSCORE AT') { |e0,e1| e0+e1 }
      clause('AT UNDERSCORE') { |e0,e1| e0+e1 }
    end

    production(:method_without_contents) do
      clause('method_modifier method_identifier WHITE? PROC') { |e0,e1,_,_| Method.new(e0+e1,[],[]) }
      clause('method_modifier method_identifier WHITE? PROCWITHARGS WHITE? argument_list right_paren') { |e0,e1,_,_,_,e2,_| Method.new(e0+e1,e2,[]) }
      clause('method_identifier WHITE? PROC') { |e,_,_| Method.new(e,[],[]) }
      clause('method_identifier WHITE? PROCWITHARGS WHITE? argument_list right_paren') { |e0,_,_,_,e1,_| Method.new(e0,e1,[]) }
    end

    production(:method) do
      clause('method_without_contents') { |e| e }
      clause('method_without_contents WHITE expression') { |e0,_,e1| e0.tap { |e| e.contents = [e1] } }
      clause('method_without_contents indented_contents') { |e0,e1| e0.tap { |e| e.contents = e1 } }
    end

    production(:unary_operator) do
      clause('PLUS')     { |e| e }
      clause('MINUS')    { |e| e }
      clause('BANG')     { |e| e }
      clause('TILDE')    { |e| e }
      clause('AMPER')    { |e| e }
      clause('QUESTION') { |e| e }
    end

    production(:unary_operation) do
      clause('unary_operator expression') { |e0,e1| UnaryOp.new(e0,e1) }
    end

    production(:arithmetic_operator) do
      clause('PLUS')     { |e| e }
      clause('MINUS')    { |e| e }
      clause('MULTIPLY') { |e| e }
      clause('DEVIDE')   { |e| e }
      clause('MODULO')   { |e| e }
      clause('EXPO')     { |e| e }
    end

    production(:comparison_operator) do
      clause('COMPARISONOP') { |e| e }
      clause('LT')           { |e| e }
      clause('GT')           { |e| e }
    end

    production(:assignment_operator) do
      clause('ASSIGNEQ')     { |e| e }
      clause('ASSIGNMENTOP') { |e| e }
    end

    production(:bitwise_operator) do
      clause('AMPER')     { |e| e }
      clause('TILDE')     { |e| e }
      clause('HAT')       { |e| e }
      clause('BITWISEOP') { |e| e }
    end

    production(:logical_operator) do
      clause('LOGICALOP') { |e| e }
    end

    production(:range_operator) do
      clause('RANGEOP') { |e| e }
    end

    production(:binary_operator) do
      clause('arithmetic_operator') { |e| e }
      clause('comparison_operator') { |e| e }
      clause('assignment_operator') { |e| e }
      clause('bitwise_operator')    { |e| e }
      clause('logical_operator')    { |e| e }
      clause('range_operator')      { |e| e }
    end

    production(:binary_operation) do
      clause('expression WHITE binary_operator WHITE expression') { |e0,_,e1,_,e2| BinaryOp.new(e1,e0,e2) }
    end

    production(:simple_identifier) do
      clause('IDENTIFIER') {|e| SimpleString.new(e) }
    end


    production(:explicit_return) do
      clause('RETURN WHITE? expression') { |_,_,e| ExplicitReturn.new(e) }
    end

    production(:outer_control_flow_word) do
      clause('IF')      { |_| If.new(nil,[]) }
      clause('UNLESS')  { |_| Unless.new(nil,[]) }
    end

    production(:control_flow) do
      clause('postfix_control_flow') { |e| e }
      clause('prefix_control_flow')  { |e| e }
    end

    production(:postfix_control_flow) do
      clause('expression WHITE outer_control_flow_word WHITE expression') { |e0,_,e1,_,e2| e1.tap { |e| e.contents = [e0]; e.test = e2 } }
    end

    production(:elsif_control_flow) do
      clause('ELSIF WHITE expression indented_contents') { |_,_,e0,e1| ElseIf.new(e0,e1) }
    end

    production(:elsif_control_flow_list) do
      clause('elsif_control_flow') { |e| e }
      clause('elsif_control_flow_list elsif_control_flow') { |e0,e1| e0.tap { |e| e.next = e1 } }
    end

    production(:else_control_flow) do
      clause('ELSE indented_contents') { |_,e1| Else.new(nil,e1) }
    end

    production(:inner_control_flow) do
      clause('elsif_control_flow_list') { |e| e }
      clause('else_control_flow')       { |e| e }
      clause('elsif_control_flow_list else_control_flow') { |e0,e1| e0.tap { |e| e.next = e1 } }
    end

    production(:outer_prefix_control_flow) do
      clause('outer_control_flow_word WHITE expression indented_contents') { |e0,_,e1,e2| e0.tap { |e| e.test = e1; e.contents = e2 } }
    end

    production(:prefix_control_flow) do
      clause('outer_prefix_control_flow') { |e| e }
      clause('outer_prefix_control_flow inner_control_flow') { |e0,e1| e0.tap { |e| e.next = e1 } }
    end

    finalize :lookahead => false
  end
end
