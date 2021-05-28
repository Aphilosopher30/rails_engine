class MerchantNameRevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant_name_revenue
  # belongs_to :merchant
  attributes :revenue, :name

end
