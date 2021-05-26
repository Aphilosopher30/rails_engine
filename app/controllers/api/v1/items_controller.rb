class Api::V1::ItemsController < ApplicationController

  def index
  end

  def show
    @item = Item.find_by(id: params[:id])
    # binding.pry
    if @item.nil?
      info_not_found
    else
      render json: ItemSerializer.new(@item)
    end
  end

end
