require 'spec_helper'

describe Rubby::Nodes::Base do
  it { should be_a(RLTK::ASTNode) }

  describe '#to_ruby' do
    let(:base) { Rubby::Nodes::Base.new }
    subject { base.to_ruby }

    context 'when it responds to :value' do
      before { base.stub(:value => 1) }

      it 'returns the value as a string' do
        expect(subject).to eq('1')
      end
    end

    context 'else' do
      it { should be_nil }
    end
  end
end
