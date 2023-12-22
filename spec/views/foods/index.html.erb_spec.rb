require 'rails_helper'

RSpec.describe 'Foods', type: :system do
  it 'displays a list of foods or a message if empty' do
    new_user = create(:user)

    visit new_user_session_path

    fill_in 'Email', with: new_user.email
    fill_in 'Password', with: new_user.password

    click_button 'Log in'

    create(:food, name: 'Pizza', measurement_unit: 'kg', price: 10.99, quantity: 5, user: new_user)
    create(:food, name: 'Salad', measurement_unit: 'g', price: 5.5, quantity: 10, user: new_user)

    visit foods_path

    within('#foods', wait: 5) do
      expect(page).to have_link('New food', href: new_food_path)

      expect(page).to have_selector('.p-2 a.btn', text: 'New food')

      if Food.all.empty?
        expect(page).to have_selector('.alert.alert-info', text: 'There are no foods in your inventory.')
      else
        expect(page).to have_selector('table')
        expect(page).to have_selector('thead th', text: 'Food')
        expect(page).to have_selector('thead th', text: 'Measurement unit')
        expect(page).to have_selector('thead th', text: 'Unit Price')
        expect(page).to have_selector('thead th', text: 'Quantity')
        expect(page).to have_selector('thead th', text: 'Actions')

        expect(page).to have_selector('tbody tr', count: 2) # Assuming there are two food items created
        expect(page).to have_content('Pizza')
        expect(page).to have_content('Salad')
      end
    end
  end
end
