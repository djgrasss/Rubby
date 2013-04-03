require 'spec_helper'

describe Rubby::Nodes::Regex do
  it { should be_a(Rubby::Nodes::Regex) }
  it { should respond_to(:value) }
end
