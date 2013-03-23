require 'spec_helper'

describe Rubby::Nodes::ControlFlow do
  let(:node) { Rubby::Nodes::ControlFlow.new(nil, []) }
  subject { node }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:test) }
  it { should respond_to(:contents) }

end
