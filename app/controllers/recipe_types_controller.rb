class RecipeTypesController < ApplicationController

  before_action :set_recipe_type, only: [:show]

  def show
    @recipes = @recipe_type.recipes
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      render :new
    end
  end

  private

  def set_recipe_type
    @recipe_type = RecipeType.find(params[:id])
  end

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end
