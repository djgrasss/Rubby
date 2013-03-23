require 'spec_helper'
describe Rubby::Nodes::InstanceArgument do
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:name) }
end
