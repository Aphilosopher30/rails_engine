require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:merchants) }
    it { should have_many :transactions}
  end
end
