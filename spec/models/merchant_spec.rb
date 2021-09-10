require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    describe '.find_by_name_fragment' do
      it 'returns list of merchants with name that includes fragment' do
        merchant1 = Merchant.create(name: "Walmart")
        merchant2 = Merchant.create(name: "Costco")
        merchant3 = Merchant.create(name: "Ace Hardware")
        merchant4 = Merchant.create(name: "Target")
        merchant5 = Merchant.create(name: "Cost Plus")

        expect(Merchant.find_by_name_fragment("Costco").count).to eq(1)
        expect(Merchant.find_by_name_fragment("Costco").first).to eq(merchant2)

        expect(Merchant.find_by_name_fragment("cost").count).to eq(2)
        expect(Merchant.find_by_name_fragment("cost").first).to eq(merchant2)

        expect(Merchant.find_by_name_fragment("kljfkahsdkf").count).to eq(0)
        expect(Merchant.find_by_name_fragment("kljfkahsdkf")).to eq([])
      end
    end
  end
end
