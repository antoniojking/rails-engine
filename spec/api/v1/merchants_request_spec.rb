require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends a list of merchants, happy path' do
    create_list(:merchant, 50)

    get "/api/v1/merchants"

    expect(Merchant.count).to eq(50)

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)

    expect(merchants[:data]).to be_an(Array)
    expect(merchants[:data].count).to be(20)


    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'sends a list of merchants, happy path: empty array when no merchants in db' do
    get "/api/v1/merchants"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)

    expect(merchants[:data]).to be_an(Array)
    expect(merchants[:data]).to eq([])
  end

  it 'sends a list of merchants, happy path: single page when less than 20 merchants'
  it 'sends a list of merchants, happy path: mulitple pages when more than 20 merchants'
  it 'sends a list of merchants, happy path: can modify page and per_page queries'
  it 'sends a list of merchants, edge path: first page with invalid page query'
  it 'sends a list of merchants, edge path: empty array for pages where page query is beyond data length'

  it 'sends a single merchant, happy path' do
    merchant1 = create(:merchant)

    get "/api/v1/merchants/#{merchant1.id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)

    expect(merchant[:data]).to be_a(Hash)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  xit 'sends a single merchant, sad path: merchant does not exist' do
    get "/api/v1/merchants/10"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)

    expect(merchant[:data]).to eq([])
  end

  describe 'finds a single merchant by name fragment api' do
    it 'happy path: name fragment query' do
      create_list(:merchant, 5)
      merchant1 = Merchant.first
      # get "/api/v1/merchants/find?name=#{merchant1.name.gsub(" ","+")}"
      get "/api/v1/merchants/find?name=#{merchant1.name.split.first}"

      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)

      expect(merchant[:data]).to be_a(Hash)

      expect(merchant[:data][:id]).to eq(merchant1.id.to_s)
      expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
    end

    it 'happy path: full name query' do
      create_list(:merchant, 5)
      merchant1 = Merchant.first

      get "/api/v1/merchants/find?name=#{merchant1.name.gsub(" ","+")}"

      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)

      expect(merchant[:data]).to be_a(Hash)

      expect(merchant[:data][:id]).to eq(merchant1.id.to_s)
      expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
    end

    it 'sad path: missing name query' do
      get "/api/v1/merchants/find"

      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)

      expect(merchant[:error]).to be_a(Hash)
      expect(merchant[:error][:message]).to eq("invalid query")
    end

    it 'sad path: missing string to name query' do
      get "/api/v1/merchants/find?name="

      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)

      expect(merchant[:error]).to be_a(Hash)
      expect(merchant[:error][:message]).to eq("invalid query")
    end
  end
end
