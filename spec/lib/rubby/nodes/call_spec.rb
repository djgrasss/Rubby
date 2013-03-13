require 'spec_helper'

describe Rubby::Nodes::Call do
  subject { Rubby::Nodes::Call.new('foo', []) }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:name) }
  it { should respond_to(:args) }
  its(:args) { should be_a(Enumerable) }
  it { should respond_to(:block) }
end
