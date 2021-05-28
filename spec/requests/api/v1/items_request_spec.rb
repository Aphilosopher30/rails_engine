require 'rails_helper'
RSpec.describe 'items'  do

  describe "get all items (item index)" do
    describe "happy path" do
      it "it can get all  items " do
        merchant0 = Merchant.create!(name: "alber")
        merchant1 = Merchant.create!(name: "bob ")
        merchant2 = Merchant.create!(name: "cat")
        merchant3 = Merchant.create!(name: "dog")

        item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
        item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
        item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
        item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
        item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
        item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
        item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
        item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
        item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
        item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
        item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
        item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

        get '/api/v1/items'
        items = JSON.parse(response.body)

        expect(items["data"].length).to eq(12)


      end

      describe 'can show one page at a time' do
        it 'first page ' do
          merchant0 = Merchant.create!(name: "alber")
          merchant1 = Merchant.create!(name: "bob ")
          merchant2 = Merchant.create!(name: "cat")
          merchant3 = Merchant.create!(name: "dog")

          item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
          item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
          item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
          item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
          item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
          item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
          item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
          item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
          item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
          item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
          item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
          item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

          get '/api/v1/items?page=1&per_page=5'
          items = JSON.parse(response.body)

          expect(items["data"].length).to eq(5)
        end

        it 'second page' do
          merchant0 = Merchant.create!(name: "alber")
          merchant1 = Merchant.create!(name: "bob ")
          merchant2 = Merchant.create!(name: "cat")
          merchant3 = Merchant.create!(name: "dog")

          item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
          item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
          item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
          item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
          item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
          item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
          item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
          item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
          item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
          item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
          item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
          item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

          get '/api/v1/items?page=2&per_page=5'
          items = JSON.parse(response.body)

          expect(items["data"].length).to eq(5)
          expect(items["data"].first["id"]).to eq(item11.id.to_s)
        end

        it 'last page can be extra short' do
          merchant0 = Merchant.create!(name: "alber")
          merchant1 = Merchant.create!(name: "bob ")
          merchant2 = Merchant.create!(name: "cat")
          merchant3 = Merchant.create!(name: "dog")

          item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
          item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
          item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
          item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
          item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
          item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
          item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
          item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
          item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
          item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
          item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
          item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

          get '/api/v1/items?page=3&per_page=5'
          items = JSON.parse(response.body)

          expect(items["data"].length).to eq(2)
        end

        it 'page number less than 1 returns page 1' do
          merchant0 = Merchant.create!(name: "alber")
          merchant1 = Merchant.create!(name: "bob ")
          merchant2 = Merchant.create!(name: "cat")
          merchant3 = Merchant.create!(name: "dog")

          item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
          item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
          item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
          item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
          item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
          item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
          item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
          item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
          item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
          item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
          item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
          item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

          first_item = Item.all.first
          last_item = Item.all[9]

          get '/api/v1/items?page=0&per_page=10'
          item = JSON.parse(response.body)

          expect(item["data"].first['id']).to eq(first_item.id.to_s)
          expect(item["data"].last['id']).to eq(last_item.id.to_s)
        end
      end
    end
  end

  describe "get one item (item showpage)" do
    it "happy path" do
      merchant1 = Merchant.create!(name: "mel")
      merchant2 = Merchant.create!(name: "har")
      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

      item1 = merchant1.items.create!(name: "one", description: "thingy", unit_price: 10)
      item2 = merchant1.items.create!(name: "two", description: "dohicky", unit_price: 10)
      item3 = merchant1.items.create!(name: "three", description: "stuff", unit_price: 10)
      item4 = merchant2.items.create!(name: "four", description: "asdfasdfsdaf saf", unit_price: 10)
      item5 = merchant2.items.create!(name: "five", description: "more", unit_price: 10)

      get "/api/v1/items/#{item2.id}"
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

  describe "get an item's merchant" do
    it "happy path" do

      merchant = Merchant.create(name: "my merchant name")
      item = merchant.items.create!(name: "one", description: "thingy", unit_price: 10)
      get "/api/v1/items/#{item.id}/merchant"
      merchant_return = JSON.parse(response.body, symbolize_names: true)


      expect(merchant_return[:data]).to have_key(:id)
      expect(merchant_return[:data][:id]).to eq(merchant.id.to_s)

      expect(merchant_return[:data][:attributes]).to have_key(:name)
      expect(merchant_return[:data][:attributes][:name]).to eq(merchant.name)
    end

    it "sad path" do
      merchant = Merchant.create(name: "my merchant name")
      get "/api/v1/items/#{33}/merchant"

      status = response.status
      expect(response.status).to eq(404)

    end
  end



  # it "find items by price" do
  #   merchant1 = Merchant.create(name: "my merchant name")
  #
  #   item1 = merchant1.items.create!(name: "one", description: "thingy", unit_price: 1)
  #   item2 = merchant1.items.create!(name: "two", description: "dohicky", unit_price: 2)
  #   item3 = merchant1.items.create!(name: "three", description: "stuff", unit_price: 3)
  #   item4 = merchant1.items.create!(name: "four", description: "asdfasdfsdaf saf", unit_price: 4)
  #   item5 = merchant1.items.create!(name: "five", description: "more", unit_price: 5)
  #
  #   get "/api/v1/items/find?max_price=4"
  #   get "/api/v1/items/find_all?min_price=2"
  #
  #
  # end

end
