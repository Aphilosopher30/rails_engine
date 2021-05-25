describe "customers API" do


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
      binding.pry

      status = response.status
      expect(response.status).to eq(404)
    end
  end

end
