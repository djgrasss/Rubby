require 'spec_helper'

describe Rubby::RubbyLoader do
  let(:loader)   { Rubby::RubbyLoader }

  describe '.load' do
    let(:filename) { File.expand_path('../../../fixtures/loader.rbb', __FILE__) }
    subject        { loader.load(filename) }

    context 'when the file exists' do
      it 'reads the file' do
        File.should_receive(:read).with(filename).and_return("1\n")
        subject
      end

      it 'transpiles the file' do
        Rubby.should_receive(:transpile).and_return('')
        subject
      end

      it 'evals the contents' do
        Kernel.should_receive(:eval)
        subject
      end

      it { should be_a(Proc) }
      its(:call) { should be_true }
    end

    context 'when the file does not exist' do
      let(:filename) { File.expand_path('../../../fixtures/not_loader.rbb', __FILE__) }
      example { expect { subject }.to raise_error(Errno::ENOENT) }
    end

    context 'when the file contains bad Rubby' do
      let(:filename) { File.expand_path('../../../fixtures/broken_loader.rbb', __FILE__) }
      example { expect { subject }.to raise_error(RLTK::NotInLanguage) }
    end
  end

  describe '.register' do
    subject { loader.register }
    it 'registers with Polyglot' do
      Polyglot.should_receive(:register).with('rbb', loader)
      subject
    end
  end
end
