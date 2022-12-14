require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    
    expect(merchants[:data].count).to eq(3)
    
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
  it 'can send one merchant' do
    id = create(:merchant).id
    
    get "/api/v1/merchants/#{id}"
    
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
    # binding.pry
    expect(merchant.count).to eq(1)
    expect(merchant[:data][:id]).to eq(id)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end