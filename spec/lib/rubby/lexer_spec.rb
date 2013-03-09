require 'spec_helper'

describe Rubby::Lexer do
  it { should be_a(RLTK::Lexer) }

  describe 'Tokens' do
    subject { Rubby::Lexer.lex(source) }
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
      shared_examples_for 'integer' do |val=nil|
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
      shared_examples_for 'float' do |val=nil|
        let(:source) { example.example_group.parent_groups[1].description }
        example('length') { expect(subject.length).to eq(2) }
        example('type') { expect(subject.first.type).to eq(:FLOAT) }
        example('value') { expect(subject.first.value).to eq(val) } if val
      end

      describe('0.123') { it_behaves_like 'float', 0.123 }

    end

    describe 'Strings' do
      shared_examples_for 'string' do |val=nil|
        let(:source) { example.example_group.parent_groups[1].description }
        example('length') { expect(subject.length).to eq(2) }
        example('type') { expect(subject.first.type).to eq(:STRING) }
        example('value') { expect(subject.first.value).to eq(val) } if val
      end

      describe(%q['hello']) { it_behaves_like 'string', 'hello' }
      describe(%q['hello \'world\'']) { it_behaves_like 'string', "hello 'world'" }
      describe(%q["hello"]) { it_behaves_like 'string', 'hello' }
      describe(%q["hello \"world\""]) { it_behaves_like 'string', 'hello "world"' }

      describe 'Embedded rubby' do
        describe %q["hello #{foo} world"] do
          let(:source) { example.example_group.description }

          example { expect(subject.size).to eq(6) }
          example { expect(subject[0].type).to eq(:STRING) }
          example { expect(subject[1].type).to eq(:STRING_CONCAT) }
          example { expect(subject[-2].type).to eq(:STRING) }
          example { expect(subject[-3].type).to eq(:STRING_CONCAT) }
        end

        describe(%q['hello #{foo} world']) { it_behaves_like 'string', 'hello #{foo} world' }
      end
    end

    describe 'Operators' do
      shared_examples_for 'operator' do |type=nil|
        let(:source) { example.example_group.parent_groups[1].description }
        example('length') { expect(subject.length).to eq(2) }
        example('type') { expect(subject.first.type).to eq(:OPERATOR) }
        example('value') { expect(subject.first.value).to eq(type) } if type
      end

      describe 'arithmetic' do
        %w[ + - * / % ** ].each do |op|
          describe(op) { it_behaves_like 'operator', op }
        end
      end

      describe 'comparison' do
        %w[ == != > < >= <= <=> === ].each do |op|
          describe(op) { it_behaves_like 'operator', op }
        end
      end

      describe 'assignment' do
        %w[ = += -= *= /= %= **= ].each do |op|
          describe(op) { it_behaves_like 'operator', op }
        end
      end

      describe 'bitwise' do
        %w[ & | ^ ~ << >> ].each do |op|
          describe(op) { it_behaves_like 'operator', op }
        end
      end

      describe 'logical' do
        %w[ && || ! ].each do |op|
          describe(op) { it_behaves_like 'operator', op }
        end
      end

      describe 'range' do
        %w[ .. ... ].each do |op|
          describe(op) { it_behaves_like 'operator', op }
        end
      end

      describe 'others' do
        %w[ . :: ?? [  ] ].each do |op|
          describe(op) { it_behaves_like 'operator', op }
        end
      end
    end
  end
end
