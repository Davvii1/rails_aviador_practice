class Category < ApplicationRecord
  include Pagination
  include Filterable

  default_scope { where(active: true) }
  scope :filter_by_name, ->(name) { where('name LIKE ?', "%#{name}%") }

  validates :active, inclusion: { in: [true, false] }
  validates :icon, presence: true
  validates :name, presence: true
end
