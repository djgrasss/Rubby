require 'spec_helper'

describe Rubby::TargetVersion do
  let(:version) { nil }
  subject { Rubby::TargetVersion.new(version) }

  it { should respond_to(:to_s) }

  context 'when version is 1.8.7' do
    let(:version) { '1.8.7p123' }
    it { should be_r18 }
    it { should_not be_r19 }
    it { should_not be_r20 }
    its(:major) { should eq(18) }
    its(:minor) { should eq(7) }
    its(:patch) { should eq(123) }
    it { should >= 18 }
    it { should <= 19 }
  end

  context 'when version is 1.9.3' do
    let(:version) { '1.9.3p456' }
    it { should_not be_r18 }
    it { should be_r19 }
    it { should_not be_r20 }
    its(:major) { should eq(19) }
    its(:minor) { should eq(3) }
    its(:patch) { should eq(456) }
    it { should >= 19 }
    it { should <= 20 }
  end

  context 'when version is 2.0.0' do
    let(:version) { '2.0.0p0' }
    it { should_not be_r18 }
    it { should_not be_r19 }
    it { should be_r20 }
    its(:major) { should eq(20) }
    its(:minor) { should eq(0) }
    its(:patch) { should eq(0) }
    it { should >= 20 }
    it { should <= 21 }
  end

  context 'when version is not set' do
    its(:version) { should eq("#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}") }
  end
end
