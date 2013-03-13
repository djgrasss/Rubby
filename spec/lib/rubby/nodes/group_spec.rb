require 'spec_helper'

describe Rubby::Nodes::Group do
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:content) }
end
