class MerchantCountRevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant_count_revenue
  # belongs_to :merchant
  attributes :count, :name

end
