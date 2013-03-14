require 'spec_helper'

describe Rubby::Transpiler do
  let(:tree) { stub(:tree) }
  let(:source) { '1' }
  let(:runner) { Rubby::Transpiler.new(source) }
  before { runner.stub(:tree => tree) }
  subject { runner }

  it { should respond_to(:target=) }
  it { should respond_to(:target) }
  it { should respond_to(:process) }

end
