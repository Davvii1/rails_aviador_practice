class PaginatedModel < ApplicationRecord
  include Pagination
end

RSpec.describe Pagination do
  let(:paginated_model_with_limit) { double('paginated_model_with_limit') }

  before do
    allow(PaginatedModel).to receive(:limit).and_return(paginated_model_with_limit)
    allow(PaginatedModel).to receive(:offset)
    allow(PaginatedModel).to receive(:all)
    allow(paginated_model_with_limit).to receive(:offset)
  end

  describe 'concern' do
    context 'when no limit or offset is provided' do
      before { PaginatedModel.pagination(nil, nil) }

      it 'calls #all' do
        expect(PaginatedModel).to have_received(:all)
      end

      it 'does not call #limit' do
        expect(PaginatedModel).not_to have_received(:limit)
      end

      it 'does not call #offset' do
        expect(PaginatedModel).not_to have_received(:offset)
      end
    end

    context 'when only limit is provided' do
      before { PaginatedModel.pagination(5, nil) }

      it 'calls #limit' do
        expect(PaginatedModel).to have_received(:limit)
      end

      it 'does not call #all' do
        expect(PaginatedModel).not_to have_received(:all)
      end

      it 'does not call #offset' do
        expect(PaginatedModel).not_to have_received(:offset)
      end
    end

    context 'when only offset is provided' do
      before { PaginatedModel.pagination(nil, 10) }

      it 'calls #offset' do
        expect(PaginatedModel).to have_received(:offset)
      end

      it 'does not call #limit' do
        expect(PaginatedModel).not_to have_received(:limit)
      end

      it 'does not call #all' do
        expect(PaginatedModel).not_to have_received(:all)
      end
    end

    context 'when both limit and offset are provided' do
      before { PaginatedModel.pagination(5, 10) }

      it 'calls #limit' do
        expect(PaginatedModel).to have_received(:limit).with(5)
      end

      it 'calls #offset' do
        expect(paginated_model_with_limit).to have_received(:offset)
      end

      it 'does not call #all' do
        expect(PaginatedModel).not_to have_received(:all)
      end
    end
  end
end
