require 'spec_helper'

describe Rubby::Nodes::Call do
  subject { Rubby::Nodes::Method.new('foo', []) }
  it { should be_a(Rubby::Nodes::Method) }
end
