require 'spec_helper'

describe Mascherari::AttrMasked do
  subject do
    Person.new
  end

  context 'when attribute comes without mask' do
    before do
      subject.phone = "1234567890"
      subject.mobile = "0987654321"
    end

    describe '#attribute_masked' do
      it 'returns attribute with mask' do
        expect(subject.phone_masked).to eq "(12) 3456-7890"
        expect(subject.mobile_masked).to eq "(09) 8765-4321"
      end
    end

    describe '#attribute_unmasked' do
      it 'returns original attribute' do
        expect(subject.phone_unmasked).to eq "1234567890"
        expect(subject.mobile_unmasked).to eq "0987654321"
      end
    end
  end

  context 'when attribute comes with mask' do
    before do
      subject.phone = "(12) 3456-7890"
      subject.mobile = "(09) 8765-4321"
    end

    describe '#attribute_masked' do
      it 'returns original attribute' do
        expect(subject.phone_masked).to eq "(12) 3456-7890"
        expect(subject.mobile_masked).to eq "(09) 8765-4321"
      end
    end

    describe '#attribute_unmasked' do
      it 'returns attribute without mask' do
        expect(subject.phone_unmasked).to eq "1234567890"
        expect(subject.mobile_unmasked).to eq "0987654321"
      end
    end
  end

  context 'when attribute value changes' do
    describe '#attribute_masked' do
      it 'masks current value' do
        subject.phone = "1234567890"

        expect(subject.phone_masked).to eq "(12) 3456-7890"

        subject.phone = "0987654321"

        expect(subject.phone_masked).to eq "(09) 8765-4321"
      end
    end

    describe '#attribute_unmasked' do
      it 'unmasks current value' do
        subject.phone = "(12) 3456-7890"

        expect(subject.phone_unmasked).to eq "1234567890"

        subject.phone = "(09) 8765-4321"

        expect(subject.phone_unmasked).to eq "0987654321"
      end
    end
  end

  context 'when have multiple formats' do
    describe '#attribute_masked' do
      it 'masks using right format' do
        subject.account = "1234567"

        expect(subject.account_masked).to eq "12.345-67"

        subject.account = "123456789"

        expect(subject.account_masked).to eq "123.456.789"
      end
    end

    describe '#attribute_unmasked' do
      it 'unmasks using right format' do
        subject.account = "12.345-67"

        expect(subject.account_unmasked).to eq "1234567"

        subject.account = "123.456.789"

        expect(subject.account_unmasked).to eq "123456789"
      end
    end

  end
end
