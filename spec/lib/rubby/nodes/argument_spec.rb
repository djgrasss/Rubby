require 'spec_helper'

describe Rubby::Nodes::Argument do
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:name) }
end
