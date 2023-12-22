require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @foods' do
      get :index
      expect(assigns(:foods)).to eq([food])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: food.id }
      expect(response).to be_successful
    end

    it 'assigns @food' do
      get :show, params: { id: food.id }
      expect(assigns(:food)).to eq(food)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new Food to @food' do
      get :new
      expect(assigns(:food)).to be_a_new(Food)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Food' do
        expect do
          post :create, params: { food: FactoryBot.attributes_for(:food) }
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the index page' do
        post :create, params: { food: FactoryBot.attributes_for(:food) }
        expect(response).to redirect_to(foods_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Food' do
        expect do
          post :create, params: { food: FactoryBot.attributes_for(:food, name: nil) }
        end.not_to change(Food, :count)
      end

      it 'renders the new template' do
        post :create, params: { food: FactoryBot.attributes_for(:food, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: food.id }
      expect(response).to be_successful
    end

    it 'assigns @food' do
      get :edit, params: { id: food.id }
      expect(assigns(:food)).to eq(food)
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the requested Food' do
        patch :update, params: { id: food.id, food: { name: 'Updated Name' } }
        food.reload
        expect(food.name).to eq('Updated Name')
      end

      it 'redirects to the show page' do
        patch :update, params: { id: food.id, food: { name: 'Updated Name' } }
        expect(response).to redirect_to(food_path(food))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested Food' do
        original_name = food.name
        patch :update, params: { id: food.id, food: { name: nil } }
        food.reload
        expect(food.name).to eq(original_name)
      end

      it 'renders the edit template' do
        patch :update, params: { id: food.id, food: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end
end
