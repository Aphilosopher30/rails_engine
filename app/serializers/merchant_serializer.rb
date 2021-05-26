class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant
  attributes :name
  

  # has_many :items
  # has_many :invoice_items, through: :items
  # has_many :invoices, through: :invoice_items
  # has_many :customers, through: :invoices
  # has_many :transactions, through: :invoices

end


# class MovieSerializer
#   include FastJsonapi::ObjectSerializer
#   set_type :movie  # optional
#   set_id :owner_id # optional
#   attributes :name, :year
#   has_many :actors
#   belongs_to :owner, record_type: :user
#   belongs_to :movie_type
# end
