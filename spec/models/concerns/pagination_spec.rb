class DummyModel < ApplicationRecord
  include Pagination
end

RSpec.describe Pagination do
  let(:dummy_model_with_limit) { double('dummy_model_with_limit') }

  before do
    allow(DummyModel).to receive(:limit).and_return(dummy_model_with_limit)
    allow(DummyModel).to receive(:offset)
    allow(DummyModel).to receive(:all)
    allow(dummy_model_with_limit).to receive(:offset)
  end

  describe 'concern' do
    context 'when no limit or offset is provided' do
      before { DummyModel.pagination(nil, nil) }

      it 'calls #all' do
        expect(DummyModel).to have_received(:all)
      end

      it 'does not call #limit' do
        expect(DummyModel).not_to have_received(:limit)
      end

      it 'does not call #offset' do
        expect(DummyModel).not_to have_received(:offset)
      end
    end

    context 'when only limit is provided' do
      before { DummyModel.pagination(5, nil) }

      it 'calls #limit' do
        expect(DummyModel).to have_received(:limit)
      end

      it 'does not call #all' do
        expect(DummyModel).not_to have_received(:all)
      end

      it 'does not call #offset' do
        expect(DummyModel).not_to have_received(:offset)
      end
    end

    context 'when only offset is provided' do
      before { DummyModel.pagination(nil, 10) }

      it 'calls #offset' do
        expect(DummyModel).to have_received(:offset)
      end

      it 'does not call #limit' do
        expect(DummyModel).not_to have_received(:limit)
      end

      it 'does not call #all' do
        expect(DummyModel).not_to have_received(:all)
      end
    end

    context 'when both limit and offset are provided' do
      before { DummyModel.pagination(5, 10) }

      it 'calls #limit' do
        expect(DummyModel).to have_received(:limit).with(5)
      end

      it 'calls #offset' do
        expect(dummy_model_with_limit).to have_received(:offset)
      end

      it 'does not call #all' do
        expect(DummyModel).not_to have_received(:all)
      end
    end
  end
end
