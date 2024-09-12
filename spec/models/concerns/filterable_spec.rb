RSpec.describe Filterable do
  before(:each) do
    # Clear all existing instances
    FilterableModel.reset_records

    # Create test data
    @item1 = FilterableModel.create('Gadget', 100)
    @item2 = FilterableModel.create('Widget', 200)
    @item3 = FilterableModel.create('Gadget', 300)
  end

  describe '.filter' do
    context 'when filtering by name' do
      it 'returns objects with the matching name' do
        puts FilterableModel.all.inspect
        results = FilterableModel.filter(name: 'Gadget')
        expect(results).to contain_exactly(@item1, @item3)
      end
    end

    # context 'when filtering by price' do
    #   it 'returns objects with the matching price' do
    #     results = FilterableModel.filter(price: 200)
    #     expect(results).to contain_exactly(@item2)
    #   end
    # end

    # context 'when filtering by multiple attributes' do
    #   it 'returns objects that match all filter criteria' do
    #     results = FilterableModel.filter(name: 'Gadget', price: 100)
    #     expect(results).to contain_exactly(@item1)
    #   end
    # end

    # context 'when filtering with missing parameters' do
    #   it 'returns all objects when no parameters are given' do
    #     results = FilterableModel.filter({})
    #     expect(results).to contain_exactly(@item1, @item2, @item3)
    #   end
    # end
  end
end
