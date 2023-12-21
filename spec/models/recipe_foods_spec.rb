require 'rails_helper'
RSpec.describe RecipeFood, type: :model do
  let(:recipe_food) { build(:recipe_food) } # ! non persisting object. It's not saved in the database.

  describe 'validations' do
    context 'object itself' do
      it 'should be valid' do
        expect(recipe_food).to be_valid
      end
    end

    context 'quantity validations' do
      it 'should be valid' do
        expect(recipe_food.quantity).to be_present
        expect(recipe_food.quantity).to be > 0
      end

      it 'should be invalid' do
        recipe_food.quantity = nil
        expect(recipe_food).to_not be_valid
      end
    end

    context 'recipe_id validations' do
      it 'should be valid' do
        expect(recipe_food.recipe_id).to be_present
      end

      it 'should be invalid' do
        recipe_food.recipe_id = nil
        expect(recipe_food).to_not be_valid
      end
    end

    context 'food_id validations' do
      it 'should be valid' do
        expect(recipe_food.food_id).to be_present
      end

      it 'should be invalid' do
        recipe_food.food_id = nil
        expect(recipe_food).to_not be_valid
      end
    end
  end
end
