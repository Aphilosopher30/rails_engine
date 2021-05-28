class Api::V1::ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    if @item.nil?
      info_not_found
    else
      render json: ItemSerializer.new(@item)
    end
  end

  def merchant
    @item = Item.find_by(id: params[:id])
    if @item.nil?
      info_not_found
    else
      merchant = @item.merchant
      render json: MerchantSerializer.new(merchant)
    end
  end

############

  def find
    if params[:name] == nil
      params[:name] = ""
    end
    exact_match = Item.find_by(name: params[:name])
    if exact_match == nil
      find_close_match
    else
      render json: ItemSerializer.new(items.first)
    end
  end

  def find_close_match
    # if params[:min_price] == nil
    #   params[:min_price] = 0
    # end
    # if params[:max_price] == nil
    #   params[:max_price] = 999999999999999999999
    # end
    items = Item.where("lower(name) like ?", "%#{params[:name].downcase}%")#.where("unit_price < ?", params[:max_price]).where("unit_price > ?", params[:min_price])
    if items == []
      info_not_found
    else
      render json: ItemSerializer.new(items.first)
    end
  end

  def find_all
    item = Item.where("lower(name) like ?", "%#{params[:name].downcase}%")
    render json: ItemSerializer.new(item)
  end

  ############


  def create
    new_item = Item.create(item_param)
    render json: ItemSerializer.new(new_item), :status => 201

    Item.destroy(new_item.id)
  end

  def update

    four_o_four = false

    if params[:item][:merchant_id] != nil
      merchant = Merchant.find_by(id: params[:item][:merchant_id])
      if merchant == nil
        four_o_four = true
      end
    end

    revised_item = Item.find_by(id: params[:id])

    if revised_item == nil
      four_o_four = true
    end

    if four_o_four == true
      info_not_found
    else
      revised_item.update(item_param)
      render json: ItemSerializer.new(revised_item)

    end



  end

  private

  def item_param
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

end
