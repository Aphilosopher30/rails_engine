class Api::V1::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find_by(id: params[:id])
  end


end
