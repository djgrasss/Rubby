require 'spec_helper'

describe Rubby::Nodes::Block do
  subject { Rubby::Nodes::Block.new([],[]) }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:args) }
  it { should respond_to(:contents) }
end
