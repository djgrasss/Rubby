require 'spec_helper'

describe Rubby::Nodes::SimpleString do
  it { should be_a(Rubby::Nodes::String) }
  it { should respond_to(:value) }
end
