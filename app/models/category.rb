class Category < ApplicationRecord
  include Pagination
  include Filterable

  default_scope { where(active: true) }

  validates :active, inclusion: { in: [true, false] }
  validates :icon, presence: true
  validates :name, presence: true
end
