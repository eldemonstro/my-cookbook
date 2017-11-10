class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :favorite,
                                    :unfavorite, :share]
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
    if current_user == @recipe.user
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
    else
      redirect_to root_path
    end
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
      flash[:alert] = 'Somente o dono da receita pode a excluir'
      redirect_to @recipe
    end
  end

  def favorite
    flash[:notice] = 'Receita favoritada com sucesso'
    current_user.favorites.create(recipe: @recipe)
    redirect_to recipe_path @recipe
  end

  def unfavorite
    flash[:notice] = 'Receita desfavoritada com sucesso'
    favorite = current_user.favorites.find_by(recipe: @recipe)
    favorite.destroy
    redirect_to recipe_path @recipe
  end

  def share
    RecipeMailer.share_recipe(@recipe.id, current_user.id, params[:name],
                              params[:email])
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
