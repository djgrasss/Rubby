require 'spec_helper'

describe Rubby::Runner do
  let(:source) { '1' }
  let(:runner) { Rubby::Runner.new(source) }
  subject { runner }
  it { should respond_to(:source) }
  it { should respond_to(:process) }
  it { should respond_to(:tokens) }
  it { should respond_to(:tree) }

  describe '#tokens' do
    subject { runner.tokens }
    it 'lexes the source' do
      Rubby::Lexer.should_receive(:lex).with(source).and_call_original
      subject
    end
  end

  describe '#tree' do
    subject { runner.tree }
    it 'parses the tokens' do
      tokens = Rubby::Lexer.lex(source)
      runner.stub(:tokens => tokens)
      Rubby::Parser.should_receive(:parse).with(tokens).and_call_original
      subject
    end
  end

  describe '#process' do
    subject { runner.process }
    example { expect { subject }.to raise_error(Rubby::Exceptions::OverrideMePlease) }
  end
end
