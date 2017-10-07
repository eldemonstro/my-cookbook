class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine

  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time,
            :ingredients, :method,
            presence: {
              message: ->(object, data) do
                "Você deve informar todos os dados da receita"
              end
            }
  def show_cook_time
    "#{cook_time} minutos"
  end
end
