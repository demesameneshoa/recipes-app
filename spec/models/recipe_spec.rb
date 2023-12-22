require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { build(:recipe) } # ! non persisting object. It's not saved in the database.

  describe 'validations' do
    context 'object itself' do
      it 'should be valid' do
        expect(recipe).to be_valid
      end
    end

    context 'name validations' do
      it 'should be valid' do
        expect(recipe.name).to be_present
      end

      it 'should be invalid' do
        recipe.name = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'preparation_time validations' do
      it 'should be valid' do
        expect(recipe.preparation_time).to be_present
        expect(recipe.preparation_time).to be > 0
      end

      it 'should be invalid' do
        recipe.preparation_time = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'cooking_time validations' do
      it 'should be valid' do
        expect(recipe.cooking_time).to be_present
        expect(recipe.cooking_time).to be > 0
      end

      it 'should be invalid' do
        recipe.cooking_time = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'description validations' do
      it 'should be valid' do
        expect(recipe.description).to be_present
      end

      it 'should be invalid' do
        recipe.description = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'public validations' do
      it 'should be valid' do
        expect(recipe.public).to be_in([true, false])
      end

      it 'should be invalid' do
        recipe.public = nil
        expect(recipe).to_not be_valid
      end
    end
  end
end
