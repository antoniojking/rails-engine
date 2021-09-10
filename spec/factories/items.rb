FactoryBot.define do
  factory :item do
    # association :merchant, factory: :merchant
    name { Faker::Commerce.unique.product_name }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Commerce.price }
    merchant_id { Faker::Number.between(from: 1, to: 5) }
  end
end
