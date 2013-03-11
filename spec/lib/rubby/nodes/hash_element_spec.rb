require 'spec_helper'

describe Rubby::Nodes::HashElement do
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:key) }
  it { should respond_to(:value) }
end
