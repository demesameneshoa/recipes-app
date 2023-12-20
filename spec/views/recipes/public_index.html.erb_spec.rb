require 'rails_helper'

RSpec.describe 'recipes/public_index', type: :system do
  it 'displays a list of public recipes or a message if empty' do
    new_user = create(:user)

    create(:recipe, name: 'Pizza', preparation_time: 10, cooking_time: 20, description: 'MyText', public: true,
                    user: new_user)
    create(:recipe, name: 'Salad', preparation_time: 5, cooking_time: 10, description: 'MyText', public: true,
                    user: new_user)

    recipes = Recipe.all

    visit root_path

    within('#public-recipes', wait: 5) do
      if Recipe.all.empty?
        expect(page).to have_selector('.alert.alert-info', text: 'There are no public recipes posted yet...')
      else
        expect(page).to have_selector('.list-unstyled', count: 1)
        expect(page).to have_selector('.card', count: recipes.length)
        expect(page).to have_selector('.card-header', text: recipes.first.name)
        expect(page).to have_selector('.card-title', text: "By: #{recipes.first.user.name}")
      end
    end
  end
end
