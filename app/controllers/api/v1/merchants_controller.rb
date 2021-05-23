class Api::V1::MerchantsController < ApplicationController

  def index
    # render json: Merchant.all

    merchants = Merchant.all
    render json: MerchantSerializer.new(merchants)

  end

  def show

    merchant = Merchant.find_by(id: params[:id])
    render json: MerchantSerializer.new(merchant)

    # render json: Merchant.find_by(id: params[:id])

  end


end
