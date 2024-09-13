class FilterableModel < ApplicationRecord
  include Filterable

  def self.find_by_name!(name); end

  def self.find_by_age!(age); end

  def self.find_by_name_and_age!(name, age); end
end

RSpec.describe Filterable do
  before do
    allow(FilterableModel).to receive(:all)
    allow(FilterableModel).to receive(:find_by_name!)
    allow(FilterableModel).to receive(:find_by_age!)
    allow(FilterableModel).to receive(:find_by_name_and_age!)
  end

  describe 'concern' do
    context 'when filtering_params is empty' do
      it 'returns all records' do
        FilterableModel.filter({})
        expect(FilterableModel).to have_received(:all)
      end
    end

    context 'when filtering_params has one key-value pair' do
      it 'calls the appropriate find_by method' do
        FilterableModel.filter(name: 'John')
        expect(FilterableModel).to have_received(:find_by_name!).with('John')
      end
    end

    context 'when filtering_params has multiple key-value pairs' do
      it 'calls the appropriate find_by method with concatenated keys' do
        FilterableModel.filter(name: 'John', age: 30)
        expect(FilterableModel).to have_received(:find_by_name_and_age!).with('John', 30)
      end
    end

    context 'when filtering_params has nil values or keys' do
      it 'ignores nil values' do
        FilterableModel.filter(name: 'John', age: nil)
        expect(FilterableModel).to have_received(:find_by_name!).with('John')
      end

      it 'ignores nil keys' do
        FilterableModel.filter(name: nil, age: 30)
        expect(FilterableModel).to have_received(:find_by_age!).with(30)
      end
    end
  end
end
