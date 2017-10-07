class HomeController < ApplicationController
  def index
    @recipes = Recipe.all
    @cuisines = Cuisine.all
    @recipe_type = RecipeType.all
  end
end
