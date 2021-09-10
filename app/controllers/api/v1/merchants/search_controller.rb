class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.find_by_name_fragment(params[:name]).first

    if params[:name].blank?
      render json: { error: { message: 'invalid query' } }
    elsif merchant.nil?
      render json: { data: {
        id: nil,
        type: 'merchant',
        attributes: { name: nil }
      } }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
