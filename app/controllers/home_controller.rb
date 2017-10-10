class HomeController < ApplicationController
  def index
    @recipes = Recipe.last(6)
    @cuisines = Cuisine.all
    @recipe_type = RecipeType.all
  end
end
