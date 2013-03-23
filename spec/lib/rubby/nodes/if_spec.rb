require 'spec_helper'

describe Rubby::Nodes::If do
  let(:contents) { [] }
  let(:test) { nil }
  let(:next_condition) { nil }
  let(:node) { Rubby::Nodes::If.new(test,contents,next_condition) }
  subject { node }
  it { should be_a(Rubby::Nodes::ControlFlow) }

  describe '#should_prefix?' do
    let(:test) { ast_for('1').first }
    subject { node.should_prefix? }
    context 'contents contains only one expression' do
      let(:contents) { ast_for('puts "Great Scott!"') }

      context 'with no next condition' do
        it { should be_true }
      end

      context 'when a next condition' do
        let(:next_condition) { ast_for("if 1\n  foo\nelse\n  foo\n").first.next }
        it { should be_false }
      end
    end

    context 'contents contains many expressions' do
      let(:contents) { ast_for("puts '1.21 Gigawatts!'\nputs 'Great Scott!'\n") }

      context 'with no next condition' do
        it { should be_false }
      end

      context 'with a next condition' do
        let(:next_condition) { ast_for("if 1\n  foo\nelse\n  foo\n").first.next }
        it { should be_false }
      end
    end
  end

  describe '#should_be_inlined?' do
    subject { node.should_be_inlined? }
    let(:content) { stub(:content) }
    context 'when there is only one expression' do
      before do
        node.contents.stub(:first => content)
        node.contents.stub(:size => 1)
      end

      context 'and that expression can be inlined' do
        before { content.stub(:should_be_inlined? => true) }

        context 'and there is no next statement' do
          before { node.stub(:next => nil) }
          it { should be_true }
        end

        context 'and there is a next statement' do
          before { node.stub(:next => true) }
          it { should be_false }
        end
      end

      context 'and that expression cannot be inlined' do
        before { content.stub(:should_be_inlined? => false) }

        context 'and there is no next statement' do
          before { node.stub(:next => nil) }
          it { should be_false }
        end

        context 'and there is a next statement' do
          before { node.stub(:next => true) }
          it { should be_false }
        end
      end
    end
  end
end
