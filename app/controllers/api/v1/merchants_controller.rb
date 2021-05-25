class Api::V1::MerchantsController < ApplicationController

  def index
    # render json: Merchant.all

    merchants = Merchant.all
    render json: MerchantSerializer.new(merchants)
    # binding.pry
  end

  def show
    merchant = Merchant.find_by(id: params[:id])


    if merchant.nil?
      # info_not_found
      # raise ActionController::RoutingError.new('Not Found')
      render  status: 404
    else
      render json: MerchantSerializer.new(merchant)
    end
  end


end
