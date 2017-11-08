class AddOwnerBooleanToUserRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :user_recipes, :owner, :boolean
  end
end
