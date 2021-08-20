require 'rails_helper'
RSpec.describe 'revenue requests'  do

  describe " total revenue of one merchant" do
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

  describe "most profitable merchant" do
    it "happy path" do
      merchant_a = Merchant.create!(name: "a")
      merchant_b = Merchant.create!(name: "b")
      merchant_c = Merchant.create!(name: "c")
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

      item_a = merchant_a.items.create!(name: "thing", description: "thingy", unit_price: 10)
      item_b = merchant_b.items.create!(name: "thing", description: "thingy", unit_price: 10)
      item_c = merchant_c.items.create!(name: "thing", description: "thingy", unit_price: 10)

      invoice = customer.invoices.create!(status: 'shipped')

      transactions = invoice.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")

      invoice_item1 = InvoiceItem.create!(item: item_b, invoice: invoice, quantity: 2, unit_price: 5)
      invoice_item2 = InvoiceItem.create!(item: item_b, invoice: invoice, quantity: 10, unit_price: 1)
      invoice_item3 = InvoiceItem.create!(item: item_a, invoice: invoice, quantity: 5, unit_price: 2)
      invoice_item4 = InvoiceItem.create!(item: item_c, invoice: invoice, quantity: 10, unit_price: 10)
      invoice_item5 = InvoiceItem.create!(item: item_a, invoice: invoice, quantity: 100, unit_price: 100)

      get "/api/v1/revenue/merchants?quantity=2"
      top_revenue  = JSON.parse(response.body)

      expect(top_revenue["data"][0]['id']).to eq(merchant_a.id.to_s)
      expect(top_revenue["data"][-1]['id']).to eq(merchant_c.id.to_s)

      expect(top_revenue["data"][0]['attributes']['revenue']).to eq(10010.0)
      expect(top_revenue["data"][-1]['attributes']['revenue']).to eq(100.0)
    end

    it "sad path" do
      # merchant_a = Merchant.create!(name: "a")
      # merchant_b = Merchant.create!(name: "b")
      # merchant_c = Merchant.create!(name: "c")
      # customer = Customer.create!(first_name: "Abe", last_name: "Oldman")
      #
      # item_a = merchant_a.items.create!(name: "thing", description: "thingy", unit_price: 10)
      # item_b = merchant_b.items.create!(name: "thing", description: "thingy", unit_price: 10)
      # item_c = merchant_c.items.create!(name: "thing", description: "thingy", unit_price: 10)
      #
      # invoice = customer.invoices.create!(status: 'shipped')
      #
      # transactions = invoice.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      #
      # invoice_item1 = InvoiceItem.create!(item: item_b, invoice: invoice, quantity: 2, unit_price: 5)
      # invoice_item2 = InvoiceItem.create!(item: item_b, invoice: invoice, quantity: 10, unit_price: 1)
      # invoice_item3 = InvoiceItem.create!(item: item_a, invoice: invoice, quantity: 5, unit_price: 2)
      # invoice_item4 = InvoiceItem.create!(item: item_c, invoice: invoice, quantity: 10, unit_price: 10)
      # invoice_item5 = InvoiceItem.create!(item: item_a, invoice: invoice, quantity: 100, unit_price: 100)
      #
      #
      #
      # get "/api/v1/revenue/merchants?quantity= "
      #
      # status = response.status
      # expect(response.status).to eq(404)
      #
      #
    end
  end


end
