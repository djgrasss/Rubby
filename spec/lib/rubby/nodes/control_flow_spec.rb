require 'spec_helper'

describe Rubby::Nodes::ControlFlow do
  subject { Rubby::Nodes::ControlFlow.new(nil, []) }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:test) }
  it { should respond_to(:contents) }
end
