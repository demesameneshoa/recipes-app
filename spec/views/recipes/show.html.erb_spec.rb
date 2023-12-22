require 'rails_helper'

RSpec.describe 'recipes/show', type: :system do
  it 'displays a list of recipes or a message if empty' do
    new_user = create(:user)
    visit new_user_session_path

    fill_in 'Email', with: new_user.email
    fill_in 'Password', with: new_user.password

    click_button 'Log in'

    create(:recipe, name: 'Pizza', preparation_time: 10, cooking_time: 20, description: 'MyText', public: false,
                    user: new_user)
    create(:recipe, name: 'Salad', preparation_time: 5, cooking_time: 10, description: 'MyText', public: false,
                    user: new_user)
    visit recipe_path(id: Recipe.first.id)

    within('#recipe-detail') do
      expect(page).to have_content('Preparation time:')
      expect(page).to have_content('Cooking time:')
      expect(page).to have_content('Description:')
      expect(page).to have_content('Generate shopping list')
    end
  end
end
