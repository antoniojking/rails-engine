require 'rails_helper'

RSpec.describe 'Items API' do
  it 'sends a list of items' do
    create_list(:merchant, 5)
    create_list(:item, 50)

    get "/api/v1/items"

    expect(Merchant.count).to eq(5)
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

  it 'sends a single item' do
    # item1 = Item.create!(name: "This Thing", description: "aldjsflasjdfl.", unit_price: 10.99, merchant_id: 1)
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant)

    get "/api/v1/items/#{item1.id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Numeric)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Numeric)
  end

  it 'does not have merchant info'

  xit 'returns 404 message when input invalid, is this something that needs to be tested?' do
    merchant = create(:merchant)
    item1 = Item.create(name: "This Thing", description: "aldjsflasjdfl.", unit_price: 10.99, merchant_id: "10")

    get "/api/v1/items/#{item1.id}"

    expect(response.status).to eq(404)
  end

  describe 'sends a list of all items by query search' do
    it 'happy path: name query returns name or description matches' do
      create_list(:merchant, 3)
      merchant1 = Merchant.first
      merchant2 = Merchant.second
      merchant3 = Merchant.last
      create_list(:item, 10, merchant: merchant1)
      create_list(:item, 10, merchant: merchant2)
      create_list(:item, 10, merchant: merchant3)
      item1 = Item.first
      item1_name_fragment = item1.name.split.first

      get "/api/v1/items/find_all?name=#{item1_name_fragment}"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(respnse.status).to eq(200)

      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:name]).to include(item1_name_fragment)
    end

    it 'happy path: min_price query' do
      create_list(:merchant, 3)
      merchant1 = Merchant.first
      merchant2 = Merchant.second
      merchant3 = Merchant.last
      create_list(:item, 10, merchant: merchant1)
      create_list(:item, 10, merchant: merchant2)
      create_list(:item, 10, merchant: merchant3)
      min_price = 4.99

      get "/api/v1/items/find_all?min_price=#{min_price}"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(respnse.status).to eq(200)

      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:unit_price]).to be_greater_than(min_price)
      expect(items[:data].last[:unit_price]).to be_greater_than(min_price)
    end

    it 'happy path: max_price query' do
      create_list(:merchant, 3)
      merchant1 = Merchant.first
      merchant2 = Merchant.second
      merchant3 = Merchant.last
      create_list(:item, 10, merchant: merchant1)
      create_list(:item, 10, merchant: merchant2)
      create_list(:item, 10, merchant: merchant3)
      max_price = 99.99

      get "/api/v1/items/find_all?max_price=#{max_price}"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(respnse.status).to eq(200)

      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:unit_price]).to be_less_than(max_price)
      expect(items[:data].last[:unit_price]).to be_less_than(max_price)
    end

    it 'happy path: min_price and max_price query' do
      create_list(:merchant, 3)
      merchant1 = Merchant.first
      merchant2 = Merchant.second
      merchant3 = Merchant.last
      create_list(:item, 10, merchant: merchant1)
      create_list(:item, 10, merchant: merchant2)
      create_list(:item, 10, merchant: merchant3)
      min_price = 4.99
      max_price = 99.99

      get "/api/v1/items/find_all?min_price=#{min_price}&max_price=#{max_price}"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(respnse.status).to eq(200)

      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:unit_price]).to be_less_than(max_price)
      expect(items[:data].first[:unit_price]).to be_greater_than(min_price)
      expect(items[:data].last[:unit_price]).to be_less_than(max_price)
      expect(items[:data].last[:unit_price]).to be_greater_than(min_price)
    end

    xit 'happy path: no results returns an empty array' do

    end

    xit 'sad path: missing query' do

    end

    xit 'sad path: missing query string' do

    end
  end
end
