require 'rails_helper'
RSpec.describe 'merchants request api tests', type: :request do

  describe "merchant index" do
    it "sends a list of merchants" do
      merchant_1 = Merchant.create(name: "marchant one")
      merchant_2 = Merchant.create(name: "marchant two")
      merchant_3 = Merchant.create(name: "marchant three")


      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants["data"].count).to eq(3)

      expect(merchants["data"][0]["id"]).to eq(merchant_1.id.to_s)
      expect(merchants["data"][0]['attributes']["name"]).to eq(merchant_1.name)

      expect(merchants["data"][1]["id"]).to eq(merchant_2.id.to_s)
      expect(merchants["data"][1]['attributes']["name"]).to eq(merchant_2.name)

      expect(merchants["data"][2]["id"]).to eq(merchant_3.id.to_s)
      expect(merchants["data"][2]['attributes']["name"]).to eq(merchant_3.name)
    end

    describe 'can show one page at a time' do
      it 'first page ' do
        create_list(:merchant, 50)

        get '/api/v1/merchants?page=1'
        merchants = JSON.parse(response.body)

        expect(merchants["data"].length).to eq(20)
      end

      it 'second page' do
        create_list(:merchant, 50)

        get '/api/v1/merchants?page=2'
        merchants = JSON.parse(response.body)

        expect(merchants["data"].length).to eq(20)
      end

      it 'last page is extra short' do
        create_list(:merchant, 50)

        get '/api/v1/merchants?page=3'
        merchants = JSON.parse(response.body)

        expect(merchants["data"].length).to eq(10)
      end

      it 'page number less than 1 returns page 1' do
        create_list(:merchant, 50)

        m = Merchant.all.first
        m20 = Merchant.all[19]


        get '/api/v1/merchants?page=0'
        merchants = JSON.parse(response.body)

        expect(merchants["data"].first['id']).to eq(m.id.to_s)
        expect(merchants["data"].last['id']).to eq(m20.id.to_s)
      end
    end


    describe 'can change number of merchants on a page ' do
      it 'can change how many merchants are on a page' do
        create_list(:merchant, 50)

        get '/api/v1/merchants?per_page=5'
        merchants = JSON.parse(response.body)

        expect(merchants["data"].length).to eq(5)
      end
      it 'can change both page and per_page simultaniously' do

        create_list(:merchant, 50)

        get '/api/v1/merchants?per_page=10&page=2'
        merchants = JSON.parse(response.body)

        expect(merchants["data"].length).to eq(10)


        m = Merchant.all[10]
        m4 = Merchant.all[19]

        expect(merchants["data"].first['id']).to eq(m.id.to_s)
        expect(merchants["data"].last['id']).to eq(m4.id.to_s)
      end
    end
  end

#########
  describe "can get one merchant by its id" do
    it "happy path " do

      merchant = Merchant.create(name: "my merchant name")

      get "/api/v1/merchants/#{merchant.id}"

      merchant_data = JSON.parse(response.body, symbolize_names: true)
      merchant_id = (merchant.id).to_s

      expect(response).to be_successful

      expect(merchant_data[:data]).to have_key(:id)
      expect(merchant_data[:data][:id]).to eq(merchant_id)

      expect(merchant_data[:data][:attributes]).to have_key(:name)
      expect(merchant_data[:data][:attributes][:name]).to be_a(String)
    end

    it "sad path " do

      merchant = Merchant.create(name: "my merchant name")

      get "/api/v1/merchants/#{merchant.id + 100}"

      status = response.status
      expect(response.status).to eq(404)
    end
  end


  describe 'merchant: find ' do

    it 'returns an exact match before a partial match' do
      merchant_1 = Merchant.create(name: "test merchant")
      merchant_2 = Merchant.create(name: "merchant test")
      merchant_3 = Merchant.create(name: "test")

      get '/api/v1/merchants/find?name=test'
      merchant = JSON.parse(response.body)

      expect(merchant["data"]["id"]).to eq(merchant_3.id.to_s)
    end
    it 'works with a partial match' do
      merchant_0 = Merchant.create(name: "1 2 3")
      merchant_1 = Merchant.create(name: "tester ")
      merchant_2 = Merchant.create(name: " testing")
      merchant_3 = Merchant.create(name: "tested")

      get '/api/v1/merchants/find?name=test'
      merchant = JSON.parse(response.body)

      expect(merchant["data"]["id"]).to eq(merchant_1.id.to_s)
    end

    it 'case insensetive' do
      merchant_1 = Merchant.create(name: "TeStInG")
      merchant_2 = Merchant.create(name: "failed")

      get '/api/v1/merchants/find?name=test'
      merchant = JSON.parse(response.body)

      expect(merchant["data"]['id']).to eq(merchant_1.id.to_s)
    end

  end


  describe 'merchant: find_all ' do

    it 'works with partial matches and exact matches' do
      merchant_1 = Merchant.create(name: "test merchant")
      merchant_2 = Merchant.create(name: "merchant test")
      merchant_3 = Merchant.create(name: "no")
      merchant_4 = Merchant.create(name: "test")

      get '/api/v1/merchants/find_all?name=test'
      merchants = JSON.parse(response.body)

      expect(merchants["data"][0]["id"]).to eq(merchant_1.id.to_s)
      expect(merchants["data"][1]["id"]).to eq(merchant_2.id.to_s)
      expect(merchants["data"][2]["id"]).to eq(merchant_4.id.to_s)
    end

    it 'case insensetive' do
      merchant_1 = Merchant.create(name: "TeStInG")
      merchant_2 = Merchant.create(name: "failed")

      get '/api/v1/merchants/find_all?name=test'
      merchants = JSON.parse(response.body)
      expect(merchants["data"][0]['id']).to eq(merchant_1.id.to_s)
    end

  end

  describe 'get items that belong to a merchant' do
    it 'gets items that belong to merchant' do
      merchant0 = Merchant.create!(name: "alber")
      merchant1 = Merchant.create!(name: "bob ")
      merchant2 = Merchant.create!(name: "cat")

      item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 5)
      item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 103)
      item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 16780)
      item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 9)
      item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
      item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 20)
      item12 = merchant1.items.create!(name: "twelve", description: "doodle", unit_price: 30)
      item20 = merchant2.items.create!(name: "twenty", description: "greee", unit_price: 6)

      get "/api/v1/merchants/#{merchant1.id}/items"
      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data].length).to eq(3)

      expect(item[:data][0][:id]).to eq(item10.id.to_s)
      expect(item[:data][0][:attributes][:name]).to eq(item10.name)
      expect(item[:data][0][:attributes][:description]).to eq(item10.description)
      expect(item[:data][0][:attributes][:unit_price]).to eq(item10.unit_price)

      expect(item[:data][1][:id]).to eq(item11.id.to_s)
      expect(item[:data][1][:attributes][:name]).to eq(item11.name)
      expect(item[:data][1][:attributes][:description]).to eq(item11.description)
      expect(item[:data][1][:attributes][:unit_price]).to eq(item11.unit_price)

      expect(item[:data][2][:id]).to eq(item12.id.to_s)
      expect(item[:data][2][:attributes][:name]).to eq(item12.name)
      expect(item[:data][2][:attributes][:description]).to eq(item12.description)
      expect(item[:data][2][:attributes][:unit_price]).to eq(item12.unit_price)
    end

  end

  # it "gets merchants with most items sold" do
  #
  #   get "/api/v1/merchants/most_items"
  #
  #
  # end

end
