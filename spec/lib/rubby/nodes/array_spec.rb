require 'spec_helper'

describe Rubby::Nodes::Array do
  subject { Rubby::Nodes::Array.new([]) }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:values) }
  its(:values) { should be_a(Enumerable) }
end
