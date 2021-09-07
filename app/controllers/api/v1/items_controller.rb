class Api::V1::ItemsController < ApplicationController
  def index
    @items = Item.paginate(page: set_page, per_page: params[:per_page] || 20)
    render json: ItemSerializer.new(@items)
  end

  def show
    @item = Item.find(params[:id])
    render json: ItemSerializer.new(@item)
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
