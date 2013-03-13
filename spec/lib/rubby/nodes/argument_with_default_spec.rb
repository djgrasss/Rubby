require 'spec_helper'

describe Rubby::Nodes::ArgumentWithDefault do
  it { should be_a(Rubby::Nodes::Argument) }
  it { should respond_to(:default) }
end
