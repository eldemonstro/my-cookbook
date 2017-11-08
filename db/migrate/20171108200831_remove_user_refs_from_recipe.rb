class RemoveUserRefsFromRecipe < ActiveRecord::Migration[5.1]
  def change
    remove_reference :recipes, :user, foreign_key: true
  end
end
