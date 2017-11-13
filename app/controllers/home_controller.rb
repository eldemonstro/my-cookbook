class HomeController < ApplicationController
  def index
    @recipes = Recipe.last(6)
    @cuisines = Cuisine.all
    @recipe_type = RecipeType.all
    @most_favorited_recipes = Recipe.joins(:favorites)
                                    .group('recipes.id')
                                    .order('count(favorites.id) DESC')
                                    .first(6)
  end

  def favorites
    @recipes = current_user.favorite_recipes
  end
end
