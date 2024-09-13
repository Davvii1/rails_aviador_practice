module Filterable
  extend ActiveSupport::Concern

  class_methods do
    def filter(filtering_params)
      @products = all
      filtered_params = filter_params(filtering_params)
      filtered_params.each do |key, value|
        @products = @products.public_send("filter_by_#{key}", value) if value.present?
      end

      @products
    end

    def filter_params(params)
      params.reject { |key, value| invalid_pair?(key, value) }
    end

    def invalid_pair?(key, value)
      key.nil? || value.nil? || value == ''
    end
  end
end
