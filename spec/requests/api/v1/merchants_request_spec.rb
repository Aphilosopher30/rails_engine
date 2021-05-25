describe "customers API" do

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

    it 'can show one page at a time' do

      create_list(:merchant, 50)

      expect(Merchant.all.length).to eq(50)


      get '/api/v1/merchants?page=1'

      # expect(Merchant["data"].length).to eq(20)

    end

    describe 'can show one page at a time' do
      it 'first page ' do
        create_list(:merchant, 50)

        get '/api/v1/merchants?page=1'
        merchants = JSON.parse(response.body)

        expect(merchants["data"].length).to eq(20)
      end

      it 'can a second page' do
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



    it 'can change how many merchants are on a page' do
      create_list(:merchant, 50)

      get '/api/v1/merchants?per_page=5'
      merchants = JSON.parse(response.body)

      expect(merchants["data"].length).to eq(5)
    end

    it 'can change how many merchants are  are on a page' do

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



  # describe "can get one merchant by its id" do
  #   it "happy path " do
  #
  #     merchant = Merchant.create(name: "my merchant name")
  #
  #     get "/api/v1/merchants/#{merchant.id}"
  #
  #     merchant_data = JSON.parse(response.body, symbolize_names: true)
  #     merchant_id = (merchant.id).to_s
  #
  #     expect(response).to be_successful
  #
  #     expect(merchant_data[:data]).to have_key(:id)
  #     expect(merchant_data[:data][:id]).to eq(merchant_id)
  #
  #     expect(merchant_data[:data][:attributes]).to have_key(:name)
  #     expect(merchant_data[:data][:attributes][:name]).to be_a(String)
  #   end
  #
  #   it "sad path " do
  #
  #     merchant = Merchant.create(name: "my merchant name")
  #
  #     get "/api/v1/merchants/#{merchant.id + 100}"
  #
  #     status = response.status
  #     expect(response.status).to eq(404)
  #   end
  # end



end
