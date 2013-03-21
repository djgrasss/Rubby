require 'spec_helper'

describe Rubby::Nodes::Else do
  let(:node) { Rubby::Nodes::Else.new(nil,[]) }
  subject { node }
  it { should be_a(Rubby::Nodes::ControlFlow) }

  describe '#should_prefix?' do
    subject { node.should_prefix? }
    it { should be_false }
  end
end
