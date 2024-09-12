class Category < ApplicationRecord
  include Pagination
  include Filterable

  scope :filter_by_name, ->(name) { where('name like ?', "%#{name}%") }

  validates :active, inclusion: { in: [true, false] }
  validates :icon, presence: true
  validates :name, presence: true
end
