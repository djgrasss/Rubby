require 'spec_helper'

describe Rubby::Transpiler do
  let(:source) { "1" }
  let(:runner) { Rubby::Transpiler.new(source) }
  subject { runner }

  it { should respond_to(:source) }
  it { should respond_to(:process) }
  it { should respond_to(:tokens) }
  it { should respond_to(:tree) }
  it { should respond_to(:target=) }
  it { should respond_to(:target) }
  it { should respond_to(:process) }

  describe '#tokens' do
    subject { runner.tokens }
    it 'lexes the source' do
      Rubby::Lexer.should_receive(:lex).with(source, 'STDIN')
      subject
    end
  end

  describe '#tree' do
    subject { runner.tree }
    it 'parses the tokens' do
      tokens = Rubby::Lexer.lex(source)
      runner.stub(:tokens => tokens)
      Rubby::Parser.should_receive(:parse).with(tokens).and_return([])
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
