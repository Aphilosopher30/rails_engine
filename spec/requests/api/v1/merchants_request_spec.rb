describe "customers API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)


    merchants.each do |merchant|
      # binding.pry
      expect(merchant).to have_key("id")
      expect(merchant["id"]).to be_an(Integer)

      expect(merchant).to have_key("name")
      expect(merchant["name"]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do

    merchant = Merchant.create(name: "my merchant name")

    get "/api/v1/merchants/#{merchant.id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

# binding.pry

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(merchant.id)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end


end