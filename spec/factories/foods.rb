require 'faker'

FactoryBot.define do
  factory :food do
    name { Faker::Food.ingredient }
    measurement_unit { 'kg' }
    price { 1.5 }
    quantity { 1 }
    user { create(:user) }
  end
end
