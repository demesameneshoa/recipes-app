require 'rails_helper'

RSpec.describe 'foods/new', type: :view do
  include Devise::Test::ControllerHelpers

  before(:each) do
    new_user = create(:user)
    assign(:food, Food.new(
                    name: 'MyString',
                    measurement_unit: 'MyString',
                    price: '9.99',
                    quantity: 1,
                    user: new_user
                  ))

    sign_in new_user
  end

  it 'renders new food form' do
    render

    assert_select 'form[action=?][method=?]', foods_path, 'post' do
      assert_select 'input[name=?]', 'food[name]'
      assert_select 'select[name=?]', 'food[measurement_unit]'
      assert_select 'input[name=?]', 'food[price]'
      assert_select 'input[name=?]', 'food[quantity]'
    end
  end
end
