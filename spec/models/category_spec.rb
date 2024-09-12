require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validate icon field requirements' do
    it 'should be present' do
      category = build :category_without_icon

      expect(category).to_not be_valid
    end
  end

  describe 'validate name field requirements' do
    it 'should be present' do
      category = build :category_without_name

      expect(category).to_not be_valid
    end
  end

  describe 'category with valid attributes' do
    it 'should be valid' do
      category = build :category

      expect(category).to be_valid
    end
  end
end
