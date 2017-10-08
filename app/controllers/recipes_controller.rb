class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = if params[:pesquisar]
      Recipe.where('title LIKE ?', "%#{params[:pesquisar]}%")
    else
      Recipe.all
    end
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def create
    @recipe = Recipe.new recipe_params
    if @recipe.save
      redirect_to @recipe
    else
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
      flash[:error] = "Você deve informar todos os dados da receita"
      render :new
    end
  end

  def edit
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
      flash[:error] = "Você deve informar todos os dados da receita"
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:message] = 'Excluido com sucesso'
    redirect_to root_path
  end

  private

  def set_recipe
    @recipe = Recipe.find params[:id]
  end

  def recipe_params
    params.require(:recipe).permit(:title, :cuisine_id, :recipe_type_id,
                                  :difficulty, :cook_time, :ingredients,
                                  :method)
  end
end
