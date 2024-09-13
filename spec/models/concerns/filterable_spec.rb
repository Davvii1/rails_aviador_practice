class FilterableModel < ApplicationRecord
  include Filterable

  def self.filter_by_name(name); end

  def self.filter_by_age(age); end
end

RSpec.describe Filterable do
  let(:filtered_records) { double('filtered_records') }
  let(:filtered_records_by_name) { double('filtered_records_by_name') }

  before do
    allow(FilterableModel).to receive(:all).and_return(filtered_records)
    allow(filtered_records).to receive(:filter_by_name).with('John').and_return(filtered_records_by_name)
    allow(filtered_records).to receive(:filter_by_age).with(30)
    allow(filtered_records_by_name).to receive(:filter_by_age).with(30)
  end

  describe 'concern' do
    context 'when filtering_params is empty' do
      it 'returns all records' do
        FilterableModel.filter({})
        expect(FilterableModel).to have_received(:all)
      end
    end

    context 'when filtering_params has one key-value pair' do
      it 'calls the appropriate filter_by method' do
        FilterableModel.filter(name: 'John')
        expect(filtered_records).to have_received(:filter_by_name).with('John')
      end
    end

    context 'when filtering_params has multiple key-value pairs' do
      it 'calls the appropriate filter_by method with concatenated keys' do
        FilterableModel.filter(name: 'John', age: 30)
        expect(filtered_records).to have_received(:filter_by_name).with('John')
      end

      it 'calls the appropriate filter_by method with concatenated keys' do
        FilterableModel.filter(name: 'John', age: 30)
        expect(filtered_records_by_name).to have_received(:filter_by_age).with(30)
      end
    end

    context 'when filtering_params has nil values or keys' do
      it 'ignores nil values' do
        FilterableModel.filter(name: 'John', age: nil)
        expect(filtered_records).to have_received(:filter_by_name).with('John')
      end

      it 'ignores nil keys' do
        FilterableModel.filter(name: nil, age: 30)
        expect(filtered_records).to have_received(:filter_by_age).with(30)
      end
    end
  end
end
