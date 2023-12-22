require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:recipe, user:) }
  let(:invalid_attributes) { attributes_for(:recipe, name: nil, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      recipe = Recipe.create! valid_attributes
      get :show, params: { id: recipe.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Recipe' do
        expect do
          post :create, params: { recipe: valid_attributes }
        end.to change(Recipe, :count).by(1)
      end

      it 'redirects to the recipes index' do
        post :create, params: { recipe: valid_attributes }
        expect(response).to redirect_to(recipes_path)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      recipe = Recipe.create! valid_attributes
      get :edit, params: { id: recipe.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'New Recipe Name' } }

      it 'updates the requested recipe' do
        recipe = Recipe.create! valid_attributes
        put :update, params: { id: recipe.to_param, recipe: new_attributes }
        recipe.reload
        expect(recipe.name).to eq('New Recipe Name')
      end

      it 'redirects to the recipe' do
        recipe = Recipe.create! valid_attributes
        put :update, params: { id: recipe.to_param, recipe: valid_attributes }
        expect(response).to redirect_to(recipe_path(recipe))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested recipe' do
      recipe = Recipe.create! valid_attributes
      expect do
        delete :destroy, params: { id: recipe.to_param }
      end.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipes list' do
      recipe = Recipe.create! valid_attributes
      delete :destroy, params: { id: recipe.to_param }
      expect(response).to redirect_to(recipes_url)
    end
  end
end
