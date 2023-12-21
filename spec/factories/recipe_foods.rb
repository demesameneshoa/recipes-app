FactoryBot.define do
  factory :recipe_food do
    food { create(:food) }
    recipe { create(:recipe) }
    quantity { 1 }
  end
end
