require 'spec_helper'

describe Rubby::Parser do
  it { should be_a(RLTK::Parser) }

  describe 'Nodes' do
    subject { parsed }
    let(:lexed) { Rubby::Lexer.lex(source) }
    let(:parsed) { Rubby::Parser.parse(lexed) }
    let(:source) { example.example_group.description }

    shared_examples_for 'node' do |klass,val=nil|
      let(:source) { example.example_group.parent_groups[1].description }
      example { expect(subject).to be_a(klass) }
      example { expect(subject.value).to eq(val) } if val
    end

    describe 'Integer literals' do
      describe('1') { it_behaves_like 'node', Rubby::Nodes::Integer, 1 }
      describe('10') { it_behaves_like 'node', Rubby::Nodes::Integer, 10 }
      describe('99') { it_behaves_like 'node', Rubby::Nodes::Integer, 99 }
      describe('1234567890123456789') { it_behaves_like 'node', Rubby::Nodes::Integer, 1234567890123456789 }
      describe('0x123') { it_behaves_like 'node', Rubby::Nodes::Integer, 291 }
      describe('0123') { it_behaves_like 'node', Rubby::Nodes::Integer, 83 }
      describe('0b10101') { it_behaves_like 'node', Rubby::Nodes::Integer, 21 }
    end

    describe 'Float literals' do
      describe('1.23') { it_behaves_like 'node', Rubby::Nodes::Float, 1.23 }
    end

    describe 'String literals' do
      describe('"foo"') { it_behaves_like 'node', Rubby::Nodes::String, 'foo' }
      describe("'foo'") { it_behaves_like 'node', Rubby::Nodes::String, 'foo' }
      disabled do
        describe('"foo #{1} baz"') { it_behaves_like 'node', Rubby::Nodes::String }
      end
    end

    describe 'Symbol literals' do
      describe(':foo')   { it_behaves_like 'node', Rubby::Nodes::Symbol }
      describe(":'foo'") { it_behaves_like 'node', Rubby::Nodes::Symbol }
      describe(':"foo"') { it_behaves_like 'node', Rubby::Nodes::Symbol }
      disabled do
        describe(':"foo #{1} baz"') { it_behaves_like 'node', Rubby::Nodes::Symbol }
      end
    end

    describe 'Array literals' do
      describe('[]') { it_behaves_like 'node', Rubby::Nodes::Array }
      describe('[1]') { it_behaves_like 'node', Rubby::Nodes::Array }
      describe('[1,2,3]') { it_behaves_like 'node', Rubby::Nodes::Array }
      describe('[ 1, 2, 3 ]') { it_behaves_like 'node', Rubby::Nodes::Array }
    end

    describe 'Hash literals' do
      describe('foo: 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('foo : 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('"foo": 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('"foo" : 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe(':foo : 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      disabled 'temporarily' do
        describe('foo: 1, bar: 2') { it_behaves_like 'node', Rubby::Nodes::Hash }
        describe('"foo": 1, 2 : 3') { it_behaves_like 'node', Rubby::Nodes::Hash }
      end
    end

    describe 'Method calls' do
      describe('foo') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo 1') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo 1, 2') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo()') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1)') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo( 1 )') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1,2,3)') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1, 2, 3 )') { it_behaves_like 'node', Rubby::Nodes::Call }

      describe('foo &>') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo() &>') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1) &>') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1,2,3) &>') { it_behaves_like 'node', Rubby::Nodes::Call }

      disabled do
        describe('foo &> 1') { it_behaves_like 'node', Rubby::Nodes::Call }
      end
    end
  end
end
