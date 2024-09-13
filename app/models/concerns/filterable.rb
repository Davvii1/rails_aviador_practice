module Filterable
  extend ActiveSupport::Concern

  class_methods do
    def filter(filtering_params)
      filtered_params = filter_params(filtering_params)
      return all if filtered_params.empty?

      if filtered_params.keys.length == 1
        public_send("find_by_#{filtered_params.keys.first}!", filtered_params.values.first)
      end

      return unless filtered_params.keys.length > 1

      public_send("find_by_#{filtered_params.keys.join('_and_')}!", *filtered_params.values)
    end

    def filter_params(params)
      params.reject { |key, value| invalid_pair?(key, value) }
    end

    def invalid_pair?(key, value)
      key.nil? || value.nil? || value == ''
    end
  end
end
