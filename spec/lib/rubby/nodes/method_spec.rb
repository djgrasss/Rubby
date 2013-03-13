require 'spec_helper'

describe Rubby::Nodes::Method do
  subject { Rubby::Nodes::Method.new('foo', [], []) }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:name) }
  it { should respond_to(:args) }
  its(:args) { should be_a(Enumerable) }
  it { should respond_to(:contents) }
  its(:contents) { should be_a(Enumerable) }
end
