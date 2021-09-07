class Api::V1::ItemsController < ApplicationController
  def index
    @items = Item.paginate(page: set_page, per_page: params[:per_page] || 20)
    render json: ItemSerializer.new(@items)
  end

  private

  def set_page
    if params[:page].present? && params[:page].to_i < 1
      1
    else
      params[:page]
    end
  end
end
