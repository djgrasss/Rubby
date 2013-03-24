require 'spec_helper'

describe Rubby::Nodes::Base do
  it { should be_a(RLTK::ASTNode) }
  let(:base) { Rubby::Nodes::Base.new }
  let(:runner) { stub(:runner) }

  describe '#to_ruby' do
    subject { base.to_ruby(runner) }

    context 'when it responds to :value' do
      before { base.stub(:value => 1) }

      it 'returns the value as a string' do
        expect(subject).to eq(['1'])
      end
    end

    context 'else' do
      example { expect { subject }.to raise_error(Rubby::Exceptions::OverrideMePlease) }
    end
  end
end
