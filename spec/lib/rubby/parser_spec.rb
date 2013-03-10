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

    describe('1') { it_behaves_like 'node', Rubby::Nodes::Integer, 1 }
    describe('1.23') { it_behaves_like 'node', Rubby::Nodes::Float, 1.23 }
    describe('"foo"') { it_behaves_like 'node', Rubby::Nodes::String, 'foo' }
    describe("'foo'") { it_behaves_like 'node', Rubby::Nodes::String, 'foo' }

    describe(':foo')   { it_behaves_like 'node', Rubby::Nodes::Symbol }
    describe(":'foo'") { it_behaves_like 'node', Rubby::Nodes::Symbol }
    describe(':"foo"') { it_behaves_like 'node', Rubby::Nodes::Symbol }

    # describe('"foo #{1} baz"') { it_behaves_like 'node', Rubby::Nodes::String }

    describe('[]') { it_behaves_like 'node', Rubby::Nodes::Array }
    describe('[1]') { it_behaves_like 'node', Rubby::Nodes::Array }
    describe('[1,2,3]') { it_behaves_like 'node', Rubby::Nodes::Array }
    describe('[ 1, 2, 3 ]') { it_behaves_like 'node', Rubby::Nodes::Array }

    describe('foo') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo 1') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo 1, 2') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo()') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo(1)') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo( 1 )') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo(1,2,3)') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo(1, 2, 3 )') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo &>') { it_behaves_like 'node', Rubby::Nodes::Call }
    # describe('foo &> 1') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo() &>') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo(1) &>') { it_behaves_like 'node', Rubby::Nodes::Call }
    describe('foo(1,2,3) &>') { it_behaves_like 'node', Rubby::Nodes::Call }
  end
end
