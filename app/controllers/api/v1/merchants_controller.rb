class Api::V1::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.paginate(page: set_page, per_page: params[:per_page] || 20)
    render json: MerchantSerializer.new(@merchants)
    # @page = params.fetch(:page, 0).to_i
    # @merchants_per_page = params.fetch(:per_page, 20).to_i
    # if @page > 0
    #   @merchants = Merchant.offset(@page * @merchants_per_page).limit(@merchants_per_page)
    # else
    #   @merchants = Merchant.offset(0).limit(@merchants_per_page)
    # end
    # render json: MerchantSerializer.new(@merchants)
  end

  def show
    @merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(@merchant)
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
