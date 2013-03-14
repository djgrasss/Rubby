require 'spec_helper'

describe Rubby::Parser do
  it { should be_a(RLTK::Parser) }

  describe 'Nodes' do
    subject { parsed.first }
    let(:lexed) { Rubby::Lexer.lex(source) }
    let(:parsed) { Rubby::Parser.parse(lexed) }
    let(:source) { example.example_group.description }

    shared_examples_for 'node' do |*args|
      klass = args.first
      val   = args[1]
      let(:source) { example.example_group.parent_groups[1].description }
      example { expect(subject).to be_a(Rubby::Nodes::Base) }
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
      describe('"foo #{1} baz"') { it_behaves_like 'node', Rubby::Nodes::String }
    end

    describe 'Symbol literals' do
      describe(':foo')   { it_behaves_like 'node', Rubby::Nodes::Symbol }
      describe(":'foo'") { it_behaves_like 'node', Rubby::Nodes::Symbol }
      describe(':"foo"') { it_behaves_like 'node', Rubby::Nodes::Symbol }
      describe(':"foo #{1} baz"') { it_behaves_like 'node', Rubby::Nodes::Symbol }
    end

    describe 'Array literals' do
      describe('[]') { it_behaves_like 'node', Rubby::Nodes::Array }
      describe('[1]') { it_behaves_like 'node', Rubby::Nodes::Array }
      describe('[1,2,3]') { it_behaves_like 'node', Rubby::Nodes::Array }
      describe('[ 1, 2, 3 ]') { it_behaves_like 'node', Rubby::Nodes::Array }
      describe('[ 1 , 2 , 3 ]') { it_behaves_like 'node', Rubby::Nodes::Array }
    end

    describe 'Hash literals' do
      describe('foo: 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('"foo": 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe(':foo: 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('foo : 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('"foo" : 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe(':foo : 1') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('foo: 1, bar: 2') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('"foo": 1, 2: 3') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('foo : 1 , bar : 2') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('"foo" : 1 , 2 : 3') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('{foo: 1}') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('{ foo: 1 }') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('{foo: 1, bar: 2}') { it_behaves_like 'node', Rubby::Nodes::Hash }
      describe('{"foo": 1, 2: 3}') { it_behaves_like 'node', Rubby::Nodes::Hash }
    end

    describe 'Method calls' do
      describe('foo') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo 1') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo 1, 2') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo 1,2') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo *bar') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo *bar,*baz') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo bar: 1, baz: 2') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo()') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1)') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo( 1 )') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1,2,3)') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1, 2, 3 )') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo( 1, 2, 3)') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo( 1, 2, 3 )') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(*foo)') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1,2,*foo)') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(*foo,*bar)') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(foo: 1, bar: 2)') { it_behaves_like 'node', Rubby::Nodes::Call }

      describe('foo &>') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo 1 &>') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo 1,2 &>') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo() &>') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1) &>') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo(1,2,3) &>') { it_behaves_like 'node', Rubby::Nodes::Call }

      describe('foo &> 1') { it_behaves_like 'node', Rubby::Nodes::Call }
      describe('foo &> bar') { it_behaves_like 'node', Rubby::Nodes::Call }

      describe("foo &>\n  1") { it_behaves_like 'node', Rubby::Nodes::Call }
      describe("foo &>\n  bar") { it_behaves_like 'node', Rubby::Nodes::Call }
      describe("foo &>\n  1\n  bar") { it_behaves_like 'node', Rubby::Nodes::Call }
    end

    describe 'blocks' do
      describe('&> 1') { it_behaves_like 'node', Rubby::Nodes::Block }
      describe("&>\n  1\n  2") { it_behaves_like 'node', Rubby::Nodes::Block }
      describe('&> (foo) 1') { it_behaves_like 'node', Rubby::Nodes::Block }
      describe("&> (foo)\n  1\n  2") { it_behaves_like 'node', Rubby::Nodes::Block }
      describe('&> (foo)') { it_behaves_like 'node', Rubby::Nodes::Block }
      describe('&> (foo,bar)') { it_behaves_like 'node', Rubby::Nodes::Block }
      describe('&> (foo,*bar)') { it_behaves_like 'node', Rubby::Nodes::Block }
      describe('&> (*foo)') { it_behaves_like 'node', Rubby::Nodes::Block }
      describe('&> (foo=bar, baz=1)') { it_behaves_like 'node', Rubby::Nodes::Block }
      describe('&> (foo: bar, baz:1)') { it_behaves_like 'node', Rubby::Nodes::Block }
    end

    describe 'class definition' do
      describe('class Foo') { it_behaves_like 'node', Rubby::Nodes::Class }
      describe('class Foo < Bar') { it_behaves_like 'node', Rubby::Nodes::Class }
      describe("class Foo\n  1\n  2") { it_behaves_like 'node', Rubby::Nodes::Class }
      describe("class Foo < Bar\n  1\n  2") { it_behaves_like 'node', Rubby::Nodes::Class }
    end

    describe 'module definition' do
      describe('module Foo') { it_behaves_like 'node', Rubby::Nodes::Module }
      describe("module Foo\n  1")
    end

    describe 'method definition' do
      describe('foo ->') { it_behaves_like 'node', Rubby::Nodes::Method }
      describe('foo -> 1') { it_behaves_like 'node', Rubby::Nodes::Method }
      describe("foo ->\n  1") { it_behaves_like 'node', Rubby::Nodes::Method }
      describe('foo -> (fred)') { it_behaves_like 'node', Rubby::Nodes::Method }
      describe('foo -> (fred, frieda)') { it_behaves_like 'node', Rubby::Nodes::Method }
      describe('foo -> (*args) 1') { it_behaves_like 'node', Rubby::Nodes::Method }
      describe("foo -> (fred='fred', frieda=nil)\n  1") { it_behaves_like 'node', Rubby::Nodes::Method }
      describe("foo -> (fred: 'fred', frieda:nil)\n  1") { it_behaves_like 'node', Rubby::Nodes::Method }
      describe('foo? ->') { it_behaves_like 'node', Rubby::Nodes::Method }
      describe('foo! ->') { it_behaves_like 'node', Rubby::Nodes::Method }
      describe('foo= ->') { it_behaves_like 'node', Rubby::Nodes::Method }
    end

    describe 'expressions' do
      describe('(1)')   { it_behaves_like 'node', Rubby::Nodes::Group }
    end

    describe 'unary operations' do
      describe('+1')    { it_behaves_like 'node', Rubby::Nodes::UnaryOp }
      describe('-1')    { it_behaves_like 'node', Rubby::Nodes::UnaryOp }
      describe('!1')    { it_behaves_like 'node', Rubby::Nodes::UnaryOp }
      describe('~1')    { it_behaves_like 'node', Rubby::Nodes::UnaryOp }
      describe('*1')    { it_behaves_like 'node', Rubby::Nodes::UnaryOp }
      describe('&1')    { it_behaves_like 'node', Rubby::Nodes::UnaryOp }
      describe('?1')    { it_behaves_like 'node', Rubby::Nodes::UnaryOp }
    end

    describe 'binary operations' do

      # Arithmetic
      describe('1 + 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 - 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 / 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 * 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 % 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 ** 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }

      # Comparison
      describe('1 < 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 > 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 == 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 != 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 >= 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 <= 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 <=> 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 === 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }

      # Assignment
      describe('1 = 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 += 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 -= 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 *= 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 /= 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 %= 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 **= 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }

      # Bitwise
      describe('1 & 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 | 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 ^ 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 ~ 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 << 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 >> 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }

      # Logical
      describe('1 && 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 || 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }

      # Range
      describe('1 .. 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
      describe('1 ... 1') { it_behaves_like 'node', Rubby::Nodes::BinaryOp }
    end
  end
end
