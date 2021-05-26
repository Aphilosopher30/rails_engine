class RevenuesController < ApplicationController



  def merch
    merchant = Merchant.find_by(id: params[:id])
    
    if merchant == nil
      info_not_found
    else
  ### move to a poro
      revenue = merchant.invoices.where('invoices.status = ?', "shipped").sum('invoice_items.quantity*invoice_items.unit_price')
  ###
      test = Thing.new(merchant.id, revenue)
      render json: MerchantRevenueSerializer.new(test)

    end
  end

end


class Thing #create poro?
  attr_reader :id, :revenue

  def initialize(id, revenue)
    @id = id
    if revenue == nil
      @revenue = 0
    else
      @revenue = revenue
    end
  end
end
