class RecipesController < ApplicationController
  # uncomment the below line to enable authentication on the public recipes page
  # public pages will be only visible across loggd in user and not to the public
  # before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def public_index
    @recipes = Recipe.includes(:user, :recipe_foods).where(public: true).order('created_at DESC')
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    unless user_signed_in?
      flash[:warning] = 'Please Sing in or Sign up to see full details! 😊'
      redirect_to root_path
    end

    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_food = @recipe.recipe_foods.includes(:food)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    respond_to do |format|
      if @recipe.save
        flash[:success] = 'Recipe was successfully created.'
        format.html { redirect_to recipes_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        flash[:info] = 'Recipe was successfully updated.'
        format.html { redirect_to recipe_url(@recipe) }
        format.json { render :show, status: :ok, location: @recipe }
      else
        flash[:danger] = 'Coulnd\'t update recipe...'
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!
    # Delete associated recipe_foods
    @recipe.recipe_foods.destroy_all

    respond_to do |format|
      flash[:info] = 'Recipe was successfully deleted.'
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
