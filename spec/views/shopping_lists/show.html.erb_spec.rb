require 'rails_helper'

RSpec.describe 'ShoppingLists#show', type: :system do
  let(:new_user) { create(:user) }

  describe 'show page' do
    before(:each) do
      visit new_user_session_path

      fill_in 'Email', with: new_user.email
      fill_in 'Password', with: new_user.password
      click_button 'Log in'
    end

    it 'displays a list of items to buy' do
      recipe = create(:recipe, user: new_user)
      food = create(:food)
      create(:recipe_food, recipe_id: recipe.id, food_id: food.id, quantity: 2000)

      visit shopping_list_path(id: 'show')

      within('#shopping-list', wait: 5) do
        expect(page).to have_selector('table')
        expect(page).to have_selector('th', text: 'Food')
        expect(page).to have_selector('th', text: 'Quantity')
        expect(page).to have_selector('th', text: 'Price')
      end
    end
  end
end
