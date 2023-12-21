require 'rails_helper'

RSpec.describe 'recipes/index', type: :system do
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

    visit recipes_path

    within('#recipes', wait: 5) do
      expect(page).to have_link('New Recipe', href: new_recipe_path)

      expect(page).to have_selector('.p-2 a.btn', text: 'New Recipe')

      expect(page).to have_selector('.p-2 a.btn', text: 'New Recipe', count: 1)

      if Recipe.all.empty?
        expect(page).to have_selector('.alert.alert-info', text: 'There are no recipes to show.')
      else
        expect(page).to have_selector('ul')
        expect(page).to have_selector('h4', text: 'Recipe')
        expect(page).to have_selector('p', text: 'Name')
        expect(page).to have_selector('p', text: 'Pizza')
        expect(page).to have_selector('p', text: 'Salad')
        expect(page).to have_selector('li', count: 2)
        expect(page).to have_content('Pizza')
        expect(page).to have_content('Salad')
        expect(page).to have_content('MyText', count: 2)
      end
    end
  end
end
