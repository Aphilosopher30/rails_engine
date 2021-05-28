require 'rails_helper'
RSpec.describe 'revenue poro'  do


  it "it exists with atributes" do

    merchant = Merchant.create!(name: "alber")

    test = Revenue.new(merchant.id, 356.5)

    expect(test.id).to eq(merchant.id)
    expect(test.name).to eq(merchant.name)
    expect(test.revenue).to eq(356.5)

  end


end
