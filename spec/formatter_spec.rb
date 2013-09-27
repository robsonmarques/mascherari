require 'spec_helper'

describe Mascherari::Formatter do
  subject do
    described_class.new :format => "(##) ####-####"
  end

  describe '#mask' do
    context 'when value is unmasked' do
      it 'returns value with mask' do
        expect(subject.mask "1234567890").to eq "(12) 3456-7890"
      end
    end

    context 'when value is already masked' do
      it 'returns value' do
        expect(subject.mask "(12) 3456-7890").to eq "(12) 3456-7890"
      end
    end
  end

  describe '#unmask' do
    context 'when value is masked' do
      it 'returns value with mask' do
        expect(subject.unmask "(12) 3456-7890").to eq "1234567890"
      end
    end

    context 'when value is already unmasked' do
      it 'returns value' do
        expect(subject.unmask "1234567890").to eq "1234567890"
      end
    end
  end

  context 'when using different wildcard' do
    subject do
      described_class.new :format => "(**) ****-****", :wildcard => "*"
    end

    describe '#mask' do
      it 'returns value with mask' do
        expect(subject.mask "1234567890").to eq "(12) 3456-7890"
      end
    end

    describe '#unmask' do
      it 'returns value without mask' do
        expect(subject.unmask "(12) 3456-7890").to eq "1234567890"
      end
    end
  end
end
