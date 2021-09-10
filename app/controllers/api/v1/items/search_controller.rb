class Api::V1::Items::SearchController < ApplicationController
  def index
    items = Item.find_all(name: params[:name])
    render json: ItemSerializer.new(items)
  end
end
