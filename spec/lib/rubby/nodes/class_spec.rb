require 'spec_helper'

describe Rubby::Nodes::Class do
  subject { Rubby::Nodes::Class.new(nil, nil, []) }
  it { should be_a(Rubby::Nodes::Base) }
  it { should respond_to(:name) }
  it { should respond_to(:super) }
  it { should respond_to(:contents) }
  its(:contents) { should be_an(Enumerable) }
end
