class Api::V1::ItemsController < ApplicationController

  def index

    page = params.fetch(:page, 1).to_i
    if page < 1
      page = 1
    end
    per_page = params.fetch(:per_page, 20).to_i
    items = Item.all.offset(per_page*(page-1)).limit(per_page)
    render json: ItemSerializer.new(items)
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
