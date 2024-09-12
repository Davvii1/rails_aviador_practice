class FilterableModel < ApplicationRecord
  include Filterable

  # Class-level storage for simulating database records
  @all_records = []

  # attr_accessor :name, :price
  # scope :filter_by_name, ->(name) { @all_records.select { |item| item.name == name } }
  scope :filter_by_name, ->(_name) { puts 'Filter by name' }

  def self.all
    @all_records
  end

  def self.reset_records
    @all_records = []
  end

  def self.filter_by_price(price)
    @all_records.select { |item| item.price == price }
  end

  def self.create(name, price)
    # instance = new(name, price)
    @all_records << { name:, price: }
  end

  # def initialize(name, price)
  #   @name = name
  #   @price = price
  # end
end
