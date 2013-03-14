require 'spec_helper'

shared_examples_for 'Runner' do
  it { should respond_to(:process) }
end

describe Rubby do
  let(:source) { stub(:source) }
  let(:runner) { stub(:runner, :process => nil) }

  describe 'runner mock' do
    subject { runner }
    it_should_behave_like 'Runner'
  end

  describe '.transpile' do
    it 'creates a new Transpiler' do
      Rubby::Transpiler.should_receive(:new).with(source,nil).and_return(runner)
      subject.transpile(source)
    end

    it 'runs the transpiler' do
      Rubby::Transpiler.stub(:new => runner)
      runner.should_receive(:process)
      subject.transpile(source)
    end
  end

  describe '.interpret' do
    it 'creates a new Interpreter' do
      Rubby::Interpreter.should_receive(:new).with(source,nil).and_return(runner)
      subject.interpret(source)
    end

    it 'runs the transpiler' do
      Rubby::Interpreter.stub(:new => runner)
      runner.should_receive(:process)
      subject.interpret(source)
    end
  end
end

describe Rubby::Transpiler do
  subject { Rubby::Transpiler.new('') }
  it_should_behave_like 'Runner'
end

describe Rubby::Interpreter do
  subject { Rubby::Interpreter.new('') }
  it_should_behave_like 'Runner'
end
