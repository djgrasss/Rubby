require 'spec_helper'

describe Rubby::Transpiler do
  let(:source) { "1" }
  let(:runner) { Rubby::Transpiler.new(source) }
  subject { runner }

  it { should respond_to(:source) }
  it { should respond_to(:process) }
  it { should respond_to(:tree) }
  it { should respond_to(:target=) }
  it { should respond_to(:target) }
  it { should respond_to(:process) }

  describe '#tree' do
    subject { runner.tree }

    it 'parses the source' do
      runner.should_receive(:parse_and_modify_source).with(source)
      subject
    end
  end

  describe '#target' do
    subject { runner.target }
    it { should be_a(Rubby::TargetVersion) }
  end

  describe '#target=' do
    it 'assigns the specified target version' do
      subject.target = '1.2.3p1'
      subject.target.to_s.should eq('1.2.3p1')
    end
  end
end
