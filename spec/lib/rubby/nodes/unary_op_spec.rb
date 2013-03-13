require 'spec_helper'

describe Rubby::Nodes::UnaryOp do
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:operator) }
  it { should respond_to(:right) }
end
