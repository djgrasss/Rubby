require 'spec_helper'

describe Rubby::Nodes::SplatArgument do
  it { should be_a(Rubby::Nodes::Argument) }

  describe '#to_ruby' do
    subject { Rubby::Nodes::SplatArgument.new('foo').to_ruby(stub(:runner)) }
    its(:size)  { should eq(1) }
    its(:first) { should eq('*foo') }
  end
end
