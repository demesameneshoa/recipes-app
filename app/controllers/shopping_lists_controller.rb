class ShoppingListsController < ApplicationController
  def show
    user_recipes = current_user.recipes

    ingredients = []
    user_recipes.each do |recipe|
      recipe.recipe_foods.each do |rf|
        ingredients << { food: rf.food, quantity: rf.quantity }
      end
    end

    combined_ingredients = Hash.new(0)
    ingredients.each do |ingredient|
      combined_ingredients[ingredient[:food]] += ingredient[:quantity]
    end

    @items_to_buy = []
    combined_ingredients.each do |current_food, required_quantity|
      existing_quantity = current_food.quantity

      next unless required_quantity > existing_quantity

      difference = required_quantity - existing_quantity
      unit_food_price = current_food.price
      @items_to_buy << { food: current_food, quantity: difference, unit_price: unit_food_price }
    end

    @items_to_buy
  end
end
