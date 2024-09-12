module Pagination
  extend ActiveSupport::Concern

  class_methods do
    def pagination(limit = nil, offset = nil)
      return limit(limit).offset(offset) if limit.present? && offset.present?
      return limit(limit) if limit.present?
      return offset(offset) if offset.present?

      all
    end
  end
end
