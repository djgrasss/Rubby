require 'spec_helper'

describe Rubby::Nodes::InterpolatedString do
  subject { Rubby::Nodes::InterpolatedString.new([]) }
  it { should be_a(Rubby::Nodes::String) }
  it { should respond_to(:contents) }
  its(:contents) { should be_an(Enumerable) }
end
