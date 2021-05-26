class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant_revenue
  # belongs_to :merchant
  attributes :revenue

end
