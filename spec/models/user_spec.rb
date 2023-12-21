require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'has many recipes' do
      user = create(:user)
      recipe1 = create(:recipe, user: user)
      recipe2 = create(:recipe, user: user)

      expect(user.recipes).to include(recipe1, recipe2)
    end
  end

  describe 'Devise modules' do
    it 'is database authenticatable' do
      user = create(:user)
      expect(user.valid_password?('123456')).to be(true)
      expect(user.valid_password?('wrong_password')).to be(false)
    end
  end
end
