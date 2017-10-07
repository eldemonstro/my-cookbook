class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.references :recipe_type, foreign_key: true
      t.references :cuisine, foreign_key: true
      t.string :difficulty
      t.text :ingredients
      t.text :method
      t.integer :cook_time

      t.timestamps
    end
  end
end
