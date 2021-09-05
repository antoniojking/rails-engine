require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get "/api/v1/merchants"

    expect(Merchant.count).to eq(5)

    merchants = JSON.parse(response.body, symbolize_name: true)

    expect(response).to be_successful

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end
  end
end
