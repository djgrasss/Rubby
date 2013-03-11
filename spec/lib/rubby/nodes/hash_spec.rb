require 'spec_helper'

describe Rubby::Nodes::Hash do
  subject { Rubby::Nodes::Hash.new([]) }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:contents) }
end
