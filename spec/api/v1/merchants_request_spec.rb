require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 50)

    get "/api/v1/merchants"

    expect(Merchant.count).to eq(50)

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      # expect(merchant[:id]).to be_an(Integer)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'sends data for a single merchant' do
    merchant1 = create(:merchant)

    get "/api/v1/merchants/#{merchant1.id}"

    expect(Merchant.count).to eq(1)

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end
