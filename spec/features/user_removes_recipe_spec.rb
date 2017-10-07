require 'rails_helper'

feature 'User removes a recipe' do
  scenario 'successfully' do
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          ingredients: 'Cenoura, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60)

    visit recipe_path(recipe)
    click_on 'Excluir'

    expect(Recipe.count).to eq 0
    expect(page).to have_content('Excluido com sucesso')
  end
end
