require 'spec_helper'

describe Mascherari::AttrMasked do
  subject do
    Person.new
  end

  context 'when attribute comes without mask' do
    before do
      subject.phone = "1234567890"
    end

    describe '#attribute_masked' do
      it 'returns attribute with mask' do
        expect(subject.phone_masked).to eq "(12) 3456-7890"
      end
    end

    describe '#attribute_unmasked' do
      it 'returns original attribute' do
        expect(subject.phone_unmasked).to eq "1234567890"
      end
    end
  end

  context 'when attribute comes with mask' do
    before do
      subject.phone = "(12) 3456-7890"
    end

    describe '#attribute_masked' do
      it 'returns original attribute' do
        expect(subject.phone_masked).to eq "(12) 3456-7890"
      end
    end

    describe '#attribute_unmasked' do
      it 'returns attribute without mask' do
        expect(subject.phone_unmasked).to eq "1234567890"
      end
    end
  end
end
