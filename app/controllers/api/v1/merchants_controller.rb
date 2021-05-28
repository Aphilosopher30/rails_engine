class Api::V1::MerchantsController < ApplicationController

  def index
    page = params.fetch(:page, 1).to_i
    if page < 1
      page = 1
    end
    per_page = params.fetch(:per_page, 20).to_i
    merchants = Merchant.all.offset(per_page*(page-1)).limit(per_page)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find_by(id: params[:id])
    if merchant.nil?
      info_not_found
    else
      render json: MerchantSerializer.new(merchant)
    end
  end

  def find
    merchant_exact = Merchant.find_by(name: params[:name])
    if merchant_exact == nil #or params[:name] = nil
      merchant = Merchant.where("lower(name) like ?", "%#{params[:name].downcase}%")
      if merchant == []
        render json: {data: {}}
      else
        render json: MerchantSerializer.new(merchant.first)
      end
    else
      render json: MerchantSerializer.new(merchant_exact)
    end
  end


  def find_all
    merchant = Merchant.where("lower(name) like ?", "%#{params[:name].downcase}%")
    render json: MerchantSerializer.new(merchant)
  end

  def items
    merchant = Merchant.find_by(id: params[:id])

    if merchant == nil
      info_not_found
    else
      items = merchant.items
      render json: ItemSerializer.new(items)
    end
  end


  def most_items
    number = params[:quantity]
    if number == nil
      render json: {}, :status => 400
      params[:quantity] = 0
    end

    merchants = Merchant.joins(items: :invoices).where('invoices.status = ?', "shipped")
      .group('merchants.id').select("merchants.*, sum(invoice_items.quantity) as total_count")
      .order(total_count: :desc).limit(number)

    revenue_list = merchants.map do |merch|
      Revenue.new(merch.id, merch.total_count)
    end

    render json: MerchantSailsRevenueSerializer.new(revenue_list)
  end

end
