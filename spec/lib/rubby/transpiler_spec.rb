require 'spec_helper'

describe Rubby::Transpiler do
  let(:tree) { stub(:tree) }
  let(:source) { '1' }
  let(:runner) { Rubby::Transpiler.new(source) }
  before { runner.stub(:tree => tree) }

  describe '#process' do
    subject { runner.process }
    it 'maps the tree' do
      tree.stub(:join)
      tree.should_receive(:map).and_return(tree)
      subject
    end

    it 'joins the result with newlines' do
      tree.stub(:map => tree)
      tree.should_receive(:join).with("\n")
      subject
    end
  end
end
