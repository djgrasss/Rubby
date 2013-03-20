require 'spec_helper'

describe Rubby::Nodes::Unless do
  subject { Rubby::Nodes::Unless.new(nil,[]) }
  it { should be_a(Rubby::Nodes::ControlFlow) }
end
