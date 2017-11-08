class CuisinesController < ApplicationController
  before_action :set_cuisine, only: [:show, :edit, :update]

  def show
    @recipes = @cuisine.recipes
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new cuisine_params
    if @cuisine.save
      redirect_to @cuisine
    else
      render :new
    end
  end

  def edit; end

  def update
    if @cuisine.update cuisine_params
      redirect_to @cuisine
    else
      render :edit
    end
  end

  private

  def set_cuisine
    @cuisine = Cuisine.find params[:id]
  end

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
