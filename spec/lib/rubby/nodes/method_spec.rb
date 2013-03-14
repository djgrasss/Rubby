require 'spec_helper'

describe Rubby::Nodes::Method do
  let(:name) { 'foo' }
  let(:args) { [] }
  let(:contents) { [] }
  let(:node) { Rubby::Nodes::Method.new(name, args, contents) }
  subject { node }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:name) }
  it { should respond_to(:args) }
  its(:args) { should be_a(Enumerable) }
  it { should respond_to(:contents) }
  its(:contents) { should be_a(Enumerable) }

  describe '#to_ruby' do
    let(:runner) { stub(:runner) }
    subject { node.to_ruby(runner) }

    context 'when the method has no contents' do
      context 'with no arguments' do
        its(:first) { should eq("def #{name}; end") }
      end

      context 'with one argument' do
        let(:args) { [ Rubby::Nodes::Argument.new('bar') ] }
        its(:first) { should eq("def #{name}(bar); end") }
      end

      context 'with two arguments' do
        let(:args) { [ Rubby::Nodes::Argument.new('bar'), Rubby::Nodes::Argument.new('baz') ] }
        its(:first) { should eq("def #{name}(bar, baz); end") }
      end
    end
  end
end
