class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  has_many :user_recipes

  before_save :add_owner_to_recipe

  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time,
            :ingredients, :method,
            presence: {
              message: 'Você deve informar todos os dados da receita'
            }

  def show_cook_time
    "#{cook_time} minutos"
  end

  def owner
    user_recipes.find(owner: true).first
  end

  private

  def add_owner_to_recipe
    user_recipes.create(owner: user)
  end
end
