require 'spec_helper'

describe Rubby::Nodes::Module do
  subject { Rubby::Nodes::Module.new(nil,[]) }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:name) }
  it { should respond_to(:contents) }
  its(:contents) { should be_an(Enumerable) }
end
