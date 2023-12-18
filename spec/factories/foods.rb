FactoryBot.define do
  factory :food do
    name { 'MyString' }
    measurement_unit { 'MyString' }
    price { '9.99' }
    quantity { 1 }
    user { nil }
  end
end
