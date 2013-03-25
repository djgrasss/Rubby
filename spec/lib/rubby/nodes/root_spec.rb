require 'spec_helper'

describe Rubby::Nodes::Root do
  subject { Rubby::Nodes::Root.new([]) }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:contents) }
  its(:contents) { should be_an(Enumerable) }
end
