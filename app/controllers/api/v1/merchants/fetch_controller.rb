class Api::V1::Merchants::FetchController < ApplicationController
  def index
    render json: Merchant.all
  end
end
