require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
    include Devise::Test::ControllerHelpers
    let(:user) { create(:user) }
    let(:recipe) { create(:recipe, user: user) }
    let(:food) { create(:food) }
    let(:valid_attributes) { attributes_for(:recipe_food, recipe_id: recipe.id, food_id: food.id) }
    let(:invalid_attributes) { attributes_for(:recipe_food, quantity: nil, recipe_id: recipe.id, food_id: food.id) }
    
    before do
        sign_in user
    end
    
    describe 'GET #new' do
        it 'returns a success response' do
        recipe_food = RecipeFood.create! valid_attributes
        get :new, params: { recipe_id: recipe_food.recipe_id }
        expect(response).to be_successful
        end
    end
    
    describe 'POST #create' do
        context 'with valid params' do
        it 'creates a new RecipeFood' do
            expect do
            post :create, params: { recipe_food: valid_attributes }
            end.to change(RecipeFood, :count).by(1)
        end
    
        it 'redirects to the recipe show page' do
            post :create, params: { recipe_food: valid_attributes }
            expect(response).to redirect_to(recipe_path(id: valid_attributes[:recipe_id]))
        end
        end
    
        context 'with invalid params' do
        it 'does not create a new RecipeFood' do
            expect do
            post :create, params: { recipe_food: invalid_attributes }
            end.to change(RecipeFood, :count).by(0)
        end
    end
end
end
