class RevenuesController < ApplicationController



  def merchant
    merchant = Merchant.find_by(id: params[:id])

    if merchant == nil
      info_not_found
    else
      revenue = merchant.invoices.where('invoices.status = ?', "shipped").sum('invoice_items.quantity*invoice_items.unit_price')


      test = Revenue.new(merchant.id, revenue)
      render json: MerchantRevenueSerializer.new(test)

    end
  end

  def most_profitable
    number = params[:quantity]
    if number == nil
      number = 0
    end

    merchants = Merchant.joins(items: {invoice_items: {invoice: :transactions}}).where('invoices.status = ?', "shipped").where('transactions.result = ?', "success")
      .group('merchants.id').select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue")
      .order(total_revenue: :desc).limit(number)

    revenue_list = merchants.map do |merch|
      Revenue.new(merch.id, merch.total_revenue)
    end
    if merchants != []
      render json: MerchantNameRevenueSerializer.new(revenue_list)
    else
      render json: {}, :status => 404
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
