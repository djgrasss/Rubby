require 'spec_helper'

describe Rubby::Nodes::Symbol do
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:content) }
end
