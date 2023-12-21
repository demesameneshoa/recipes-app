require 'rails_helper'

RSpec.describe ShoppingListsController, type: :controller do
  include Devise::Test::ControllerHelpers

  new_user = FactoryBot.create(:user)
  recipe = FactoryBot.create(:recipe, user: new_user)
  food = FactoryBot.create(:food)
  FactoryBot.create(:recipe_food, recipe_id: recipe.id, food_id: food.id, quantity: 2)

  before do
    sign_in new_user
  end

  describe 'GET #show' do
    it 'assigns @items_to_buy' do
      get :show, params: { id: 'show' }
      expect(response).to be_successful
    end
  end
end
