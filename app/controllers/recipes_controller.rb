class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update,
                                            :destroy]

  def index
    @recipes = Recipe.where('title LIKE ?', "%#{params[:pesquisar]}%")
  end

  def show; end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def create
    @recipe = Recipe.new recipe_params
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
      flash[:error] = 'Você deve informar todos os dados da receita'
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
      flash[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  def destroy
    if @recipe.user == current_user
      @recipe.destroy
      flash[:notice] = 'Excluido com sucesso'
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def favorite
    flash[:notice] = 'Receita favoritada com sucesso'
    current_user.favorites.create(recipe: @recipe)
    redirect_to recipe_path @recipe
  end

  private

  def set_recipe
    @recipe = Recipe.find params[:id]
  end

  def recipe_params
    params.require(:recipe).permit(:title, :cuisine_id, :recipe_type_id,
                                   :difficulty, :featured, :cook_time,
                                   :ingredients, :method)
  end
end
