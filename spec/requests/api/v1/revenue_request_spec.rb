require 'rails_helper'
RSpec.describe 'revenue requests'  do

  describe "revenue of one merchant" do
    it "happy path" do
      merchant = Merchant.create!(name: "mel")
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

      item1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice2 = customer.invoices.create!(status: 'shipped')
      invoice1 = customer.invoices.create!(status: 'shipped')
      invoice3 = customer.invoices.create!(status: 'returned')

      invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5)
      invoice_item2 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 10, unit_price: 1)
      invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 5, unit_price: 2)
      invoice_item4 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 1, unit_price: 10)
      invoice_item5 = InvoiceItem.create!(item: item1, invoice: invoice3, quantity: 100, unit_price: 100)



      get "/api/v1/revenue/merchants/#{merchant.id}"

      revenue  = JSON.parse(response.body)

      expect(revenue["data"]['id']).to eq(merchant.id.to_s)
      expect(revenue["data"]['attributes']['revenue']).to eq(40.0)
    end

    it "sad path" do
      merchant = Merchant.create!(name: "mel")
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

      item1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
      invoice2 = customer.invoices.create!(status: 'shipped')
      invoice1 = customer.invoices.create!(status: 'shipped')
      invoice3 = customer.invoices.create!(status: 'returned')

      invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5)
      invoice_item2 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 10, unit_price: 1)
      invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 5, unit_price: 2)
      invoice_item4 = InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 1, unit_price: 10)
      invoice_item5 = InvoiceItem.create!(item: item1, invoice: invoice3, quantity: 100, unit_price: 100)



      get "/api/v1/revenue/merchants/#{merchant.id+100}"

      status = response.status
      expect(response.status).to eq(404)



    end
  end
end
