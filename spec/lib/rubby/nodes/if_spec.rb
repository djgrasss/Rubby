require 'spec_helper'

describe Rubby::Nodes::If do
  subject { Rubby::Nodes::If.new(nil,[]) }
  it { should be_a(Rubby::Nodes::ControlFlow) }
end
