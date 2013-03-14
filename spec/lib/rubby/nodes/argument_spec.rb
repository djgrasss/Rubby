require 'spec_helper'

describe Rubby::Nodes::Argument do
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:name) }

  describe '#to_ruby' do
    subject { Rubby::Nodes::Argument.new('foo').to_ruby(stub(:runner)) }
    its(:size)  { should eq(1) }
    its(:first) { should eq('foo') }
  end
end
