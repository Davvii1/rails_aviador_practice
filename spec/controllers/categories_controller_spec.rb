require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:categories) { double('categories') }

  before do
    allow(Category).to receive(:filter).with(ActionController::Parameters).and_return(categories)
    allow(categories).to receive(:pagination).with(nil, nil).and_return(categories)
    allow(categories).to receive(:pagination).with(5, nil).and_return(categories)
    allow(categories).to receive(:pagination).with(nil, 10).and_return(categories)
    allow(categories).to receive(:pagination).with(5, 10).and_return(categories)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns all categories' do
      get :index
      expect(assigns(:categories)).to eq(categories)
    end

    it 'returns categories with name params' do
      get :index, params: { name: 'category_name' }
      expect(assigns(:categories)).to eq(categories)
    end

    it 'returns categories with name and limit params' do
      get :index, params: { name: 'category_name', limit: 5 }
      expect(assigns(:categories)).to eq(categories)
    end

    it 'returns categories with name and offset params' do
      get :index, params: { name: 'category_name', offset: 10 }
      expect(assigns(:categories)).to eq(categories)
    end

    it 'returns categories with name, limit and offset params' do
      get :index, params: { name: 'category_name', limit: 5, offset: 10 }
      expect(assigns(:categories)).to eq(categories)
    end

    it 'returns categories with limit params' do
      get :index, params: { limit: 5 }
      expect(assigns(:categories)).to eq(categories)
    end

    it 'returns categories with offset params' do
      get :index, params: { offset: 10 }
      expect(assigns(:categories)).to eq(categories)
    end

    it 'returns categories with limit and offset params' do
      get :index, params: { limit: 5, offset: 10 }
      expect(assigns(:categories)).to eq(categories)
    end
  end
end
