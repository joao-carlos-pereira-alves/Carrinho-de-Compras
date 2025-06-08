# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    name { "Samsung Galaxy S24 Ultra" }
    price { 10.0 }
  end
end