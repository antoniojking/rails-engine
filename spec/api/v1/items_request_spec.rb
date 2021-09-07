require 'rails_helper'

RSpec.describe 'Items API' do
  it 'sends a list of items' do
    create_list(:merchant, 5)
    create_list(:item, 50)

    get "/api/v1/items"

    expect(Item.count).to eq(50)

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Numeric)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Numeric)
    end
  end

  it 'does not have data for merchant'
end
