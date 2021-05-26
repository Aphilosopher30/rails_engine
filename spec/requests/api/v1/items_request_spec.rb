require 'rails_helper'
RSpec.describe 'items'  do

  describe "get all items (item index)" do
    it "happy path" do
      merchant1 = Merchant.create!(name: "mel")
      merchant2 = Merchant.create!(name: "har")
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

      item1 = merchant1.items.create!(name: "one", description: "thingy", unit_price: 10)
      item2 = merchant1.items.create!(name: "two", description: "dohicky", unit_price: 10)
      item3 = merchant1.items.create!(name: "three", description: "stuff", unit_price: 10)
      item4 = merchant2.items.create!(name: "four", description: "asdfasdfsdaf saf", unit_price: 10)
      item5 = merchant2.items.create!(name: "five", description: "more", unit_price: 10)

      get "http://localhost:3000/api/v1/items/#{item2.id}"
      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to eq(item2.id.to_s)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to eq(item2.name)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to eq(item2.description)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to eq(item2.unit_price)


      get "http://localhost:3000/api/v1/items/#{item4.id}"
      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to eq(item4.id.to_s)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to eq(item4.name)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to eq(item4.description)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to eq(item4.unit_price)
    end


    it "sad path" do
      merchant = Merchant.create(name: "my merchant name")
      item = merchant.items.create!(name: "one", description: "thingy", unit_price: 10)

      get "/api/v1/merchants/#{item.id + 100}"

      status = response.status
      expect(response.status).to eq(404)
    end
  end

  describe "get one item (item showpage)" do
    it "happy path" do
    end

    it "sad path" do
    end
  end

  describe "get an items merchant" do
    it "happy path" do
    end

    it "sad path" do
    end
  end


end
