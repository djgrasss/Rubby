require 'spec_helper'

describe Rubby::Lexer do
  it { should be_a(RLTK::Lexer) }

  describe 'Tokens' do
    let(:lexed) { Rubby::Lexer.lex(source) }
    subject { lexed }
    let(:source) { example.example_group.description }
    describe 'Identifiers' do
      shared_examples_for 'identifier' do
        let(:source) { example.example_group.parent_groups[1].description }
        example { expect(subject.length).to eq(2) }
        example { expect(subject.first.type).to eq(:IDENTIFIER) }
      end

      describe('foo')       { it_behaves_like 'identifier' }
      describe('fooBar')    { it_behaves_like 'identifier' }
      describe('fooBar99')  { it_behaves_like 'identifier' }
      describe('foo99Bar')  { it_behaves_like 'identifier' }
      describe('foo?')      { it_behaves_like 'identifier' }
      describe('fooBar?')   { it_behaves_like 'identifier' }
      describe('foo99Bar?') { it_behaves_like 'identifier' }
      describe('foo!')      { it_behaves_like 'identifier' }
      describe('fooBar!')   { it_behaves_like 'identifier' }
      describe('foo99Bar!') { it_behaves_like 'identifier' }
      describe('foo=')      { it_behaves_like 'identifier' }
      describe('fooBar=')   { it_behaves_like 'identifier' }
      describe('foo99Bar=') { it_behaves_like 'identifier' }
      describe('foo_bar')   { it_behaves_like 'identifier' }
      describe('foo_bar!')  { it_behaves_like 'identifier' }
      describe('foo_bar?')  { it_behaves_like 'identifier' }
    end

    describe 'Constants' do
      shared_examples_for 'constant' do
        let(:source) { example.example_group.parent_groups[1].description }
        example { expect(subject.length).to eq(2) }
        example { expect(subject.first.type).to eq(:CONSTANT) }
      end

      describe('Foo')    { it_behaves_like 'constant' }
      describe('Foo99')  { it_behaves_like 'constant' }
      describe('Foo_99') { it_behaves_like 'constant' }
      describe('Foo_')   { it_behaves_like 'constant' }
    end

    describe 'Integers' do
      shared_examples_for 'integer' do |*args|
        val = args.first
        let(:source) { example.example_group.parent_groups[1].description }
        example('length') { expect(subject.length).to eq(2) }
        example('type') { expect(subject.first.type).to eq(:INTEGER) }
        example('value') { expect(subject.first.value).to eq(val) } if val
      end

      describe('1') { it_behaves_like 'integer', 1 }
      describe('1') { it_behaves_like 'integer', 1 }
      describe('100') { it_behaves_like 'integer', 100 }
      describe('123456789') { it_behaves_like 'integer', 123456789 }
      describe('9') { it_behaves_like 'integer', 9 }

      describe('0x1f') { it_behaves_like 'integer', 31 }

      describe('0123') { it_behaves_like 'integer', 83 }

      describe('0b01011101') { it_behaves_like 'integer', 93 }
    end

    describe 'Floats' do
      shared_examples_for 'float' do |*args|
        val = args.first
        let(:source) { example.example_group.parent_groups[1].description }
        example('length') { expect(subject.length).to eq(2) }
        example('type') { expect(subject.first.type).to eq(:FLOAT) }
        example('value') { expect(subject.first.value).to eq(val) } if val
      end

      describe('0.123') { it_behaves_like 'float', 0.123 }

    end

    describe 'Strings' do
      shared_examples_for 'string' do |*args|
        val = args.first
        let(:source) { example.example_group.parent_groups[1].description }
        example('length') { expect(subject.length).to eq(4) }
        example('type') { expect(subject[1].type).to eq(:STRING) }
        example('value') { expect(subject[1].value).to eq(val) } if val
      end

      describe(%q['hello']) { it_behaves_like 'string', 'hello' }
      describe(%q['hello \'world\'']) { it_behaves_like 'string', "hello 'world'" }
      describe(%q["hello"]) { it_behaves_like 'string', 'hello' }
      describe(%q["hello \"world\""]) { it_behaves_like 'string', 'hello "world"' }

      describe 'String Interpolation' do
        shared_examples_for 'interpolated_string' do |*args|
          val = args.first
          let(:source) { example.example_group.parent_groups[1].description }
          let(:uniq_types) do
            last = nil
            subject.map do |elem|
              type = elem.type
              last = type unless last == type
            end.compact
          end
          example { expect(uniq_types.size).to eq(6) }
          example { puts uniq_types.inspect }
          example { expect(uniq_types[0]).to eq(:STRING) }
          example { expect(uniq_types[1]).to eq(:INTERPOLATESTART) }
          example { expect(uniq_types[-3]).to eq(:INTERPOLATEEND) }
          example { expect(uniq_types[-2]).to eq(:STRING) }
        end

        describe(%q["hello #{foo} world"]) { it_behaves_like 'interpolated_string' }
        describe(%q["#{foo}"]) { it_behaves_like 'interpolated_string' }

        describe(%q['hello #{foo} world']) { it_behaves_like 'string', 'hello #{foo} world' }
      end
    end

    describe 'Operators' do
      shared_examples_for 'operator' do |*args|
        type = args.first
        val = args[1]
        let(:source) { example.example_group.parent_groups[1].description }
        example('length') { expect(subject.length).to eq(2) }
        example('type') { expect(subject.first.type).to eq(type) }
        example('value') { expect(subject.first.value).to eq(val) } if val
      end

      describe 'arithmetic' do
        describe('**') { it_behaves_like 'operator', :EXPO, '**' }
        describe('+')  { it_behaves_like 'operator', :PLUS, '+' }
        describe('-')  { it_behaves_like 'operator', :MINUS, '-' }
        describe('*')  { it_behaves_like 'operator', :MULTIPLY, '*' }
        describe('/')  { it_behaves_like 'operator', :DEVIDE, '/' }
        describe('%')  { it_behaves_like 'operator', :MODULO, '%' }
      end

      describe 'comparison' do
        %w[ == != > < >= <= <=> === ].each do |op|
          describe(op) { it_behaves_like 'operator', :COMPARISONOP, op }
        end
      end

      describe 'assignment' do
        %w[ = += -= *= /= %= **= ].each do |op|
          describe(op) { it_behaves_like 'operator', :ASSIGNMENTOP, op }
        end
      end

      describe 'bitwise' do
        %w[ & | ^ << >> ].each do |op|
          describe(op) { it_behaves_like 'operator', :BITWISEOP, op }
        end
      end

      describe 'logical' do
        describe('!') { it_behaves_like 'operator', :BANG, '!' }
        describe('~') { it_behaves_like 'operator', :TILDE, '~' }
        %w[ && || ].each do |op|
          describe(op) { it_behaves_like 'operator', :LOGICALOP, op }
        end
      end

      describe 'range' do
        %w[ .. ... ].each do |op|
          describe(op) { it_behaves_like 'operator', :RANGEOP, op }
        end
      end

      describe 'others' do
        describe('.') { it_behaves_like 'operator', :DOT, '.' }
        describe('::') { it_behaves_like 'operator', :CONSTINDEXOP, '::' }
        describe('??') { it_behaves_like 'operator', :DEFINEDOP, '??' }
        describe('[')  { it_behaves_like 'operator', :LSQUARE, '[' }
        describe(']')  { it_behaves_like 'operator', :RSQUARE, ']' }
        describe('(')  { it_behaves_like 'operator', :LPAREN, '(' }
        describe(')')  { it_behaves_like 'operator', :RPAREN, ')' }
        describe('{')  { it_behaves_like 'operator', :LCURLY, '{' }
        describe('{')  { it_behaves_like 'operator', :LCURLY, '{' }
        describe(',')  { it_behaves_like 'operator', :COMMA, ',' }
        describe('@')  { it_behaves_like 'operator', :AT, '@' }
        describe('->')  { it_behaves_like 'operator', :PROC, '->' }
        describe('&>')  { it_behaves_like 'operator', :BLOCK, '&>' }
        describe(':')  { it_behaves_like 'operator', :COLON, ':' }
      end
    end

    describe 'Comments' do
      shared_examples_for 'comment' do |*args|
        val = args.first
        let(:source) { example.example_group.parent_groups[1].description }
        example { expect(subject.length).to eq(2) }
        example { expect(subject.first.type).to eq(:COMMENT) }
        example { expect(subject.first.value).to eq(val) } if val
      end
      describe('# foo') { it_behaves_like('comment', 'foo') }
      describe('#    foo') { it_behaves_like('comment', 'foo') }
      describe('#### foo') { it_behaves_like('comment', 'foo') }
    end

    describe 'Keywords' do
      shared_examples_for 'keyword' do |type|
        let(:source) { example.example_group.parent_groups[1].description }
        example { expect(subject.length).to eq(2) }
        example { expect(subject.first.type).to eq(type) }
      end

      %w[ class module ].each do |keyword|
        describe(keyword) { it_behaves_like('keyword', keyword.upcase.to_sym) }
      end
    end

    describe 'Indent/Dedent' do
      subject { lexed.map(&:type) }

      describe "no indent" do
        let(:source) { "1\n2\n" }
        it { should_not include(:INDENT) }
      end

      describe "single indent" do
        let(:source) { "1\n  2" }
        it { should include(:INDENT) }
      end

      describe 'uneven indent' do
        let(:source) { "1\n   2" }
        example { expect { subject }.to raise_error(Rubby::Exceptions::Indent) }
      end

      describe "double indent" do
        let(:source) { "1\n    2" }
        example { expect { subject }.to raise_error(Rubby::Exceptions::Indent) }
      end

      describe "dedent to zero" do
        let(:source) { "1\n  2\n3" }
        it { should include(:DEDENT) }
      end

      describe "dedent to one" do
        let(:source) { "1\n  2\n    3\n  4" }
        its(:size) { should eq(11) }
        it { should include(:DEDENT) }
      end
    end
  end

  describe Rubby::Lexer::Environment do
    describe '#indent_token_for' do
      let(:environment) { Rubby::Lexer::Environment.new(:default) }
      let(:old_depth) { 0 }
      let(:new_depth) { 0 }
      before { environment.current_indent_level = old_depth / 2 }
      subject { environment.indent_token_for(new_depth) }

      shared_examples_for 'dent token' do |*args|
        token = args.first || :INDENT
        value = args[1]
        it { should be_a(Enumerable) }
        its(:size) { should eq(2) }
        its(:first) { should eq(token) }
        its(:last) { should eq(value) } if value
      end

      describe 'from 0 to 1.5' do
        let(:new_depth) { 3 }
        example { expect { subject }.to raise_error(Rubby::Exceptions::Indent) }
      end

      describe 'from 0 to 0' do
        it { should be_nil }
      end

      describe 'from 5 to 5' do
        let(:old_depth) { 10 }
        let(:new_depth) { 10 }
        it { should be_nil }
      end

      describe 'from 0 to 1' do
        let(:new_depth) { 2 }
        it_behaves_like 'dent token', :INDENT, 1
      end

      describe 'from 1 to 2' do
        let(:old_depth) { 2 }
        let(:new_depth) { 4 }
        it_behaves_like 'dent token', :INDENT, 2
      end

      describe 'from 10 to 11' do
        let(:old_depth) { 20 }
        let(:new_depth) { 22 }
        it_behaves_like 'dent token', :INDENT, 11
      end

      describe 'from 1 to 3' do
        let(:old_depth) { 2 }
        let(:new_depth) { 6 }
        example { expect { subject }.to raise_error(Rubby::Exceptions::Indent) }
      end

      describe 'from 1 to 0' do
        let(:old_depth) { 2 }
        let(:new_depth) { 0 }
        it_behaves_like 'dent token', :DEDENT, 0
      end

      describe 'from 2 to 0' do
        let(:old_depth) { 4 }
        let(:new_depth) { 0 }
        it_behaves_like 'dent token', :DEDENT, 0
      end

      describe 'from 50 to 0' do
        let(:old_depth) { 100 }
        let(:new_depth) { 0 }
        it_behaves_like 'dent token', :DEDENT, 0
      end
    end
  end
end
