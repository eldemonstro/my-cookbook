class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user
  has_many :favorites

  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time,
            :ingredients, :method,
            presence: {
              message: 'Você deve informar todos os dados da receita'
            }

  def show_cook_time
    "#{cook_time} minutos"
  end
end
