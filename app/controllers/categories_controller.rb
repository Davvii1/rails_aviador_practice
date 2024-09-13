class CategoriesController < ApplicationController
  def index
    @categories = Category
                  .filter(filtering_params)
                  .pagination(pagination_limit, pagination_offset)

    render json: @categories
  end

  def new; end

  def edit; end

  def create; end

  def update; end

  def delete; end

  private

  def pagination_limit
    params[:limit].to_i if params[:limit].present?
  end

  def pagination_offset
    params[:offset].to_i if params[:offset].present?
  end

  def filtering_params
    params.slice(:name)
  end
end
