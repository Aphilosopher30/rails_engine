class Api::V1::MerchantsController < ApplicationController

  def index

    page = params.fetch(:page, 1).to_i
    if page < 1
      page = 1
    end
    per_page = params.fetch(:per_page, 20).to_i
    merchants = Merchant.all.offset(per_page*(page-1)).limit(per_page)
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
