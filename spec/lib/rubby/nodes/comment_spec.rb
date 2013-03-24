require 'spec_helper'

describe Rubby::Nodes::Comment do
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:value) }
end
