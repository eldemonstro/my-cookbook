require 'rails_helper'

feature 'User searches a recipe' do
  scenario 'successfully' do
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          ingredients: 'Cenoura, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60)

    visit root_path
    fill_in 'pesquisar', with: 'Bolo de cenoura'
    find('input[name="commit"]').click

    expect(page).to have_content('Bolo de cenoura')
  end

  scenario 'and finds nothing' do
    visit root_path
    fill_in 'pesquisar', with: 'Bolo de cenoura'
    find('input[name="commit"]').click

    expect(page).to have_content('Nenhuma receita encontrada')
  end

  scenario 'and finds various recipes' do
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          ingredients: 'Cenoura, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60)

    Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          ingredients: 'Chocolate, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60)

    visit root_path
    fill_in 'pesquisar', with: 'Bolo'
    find('input[name="commit"]').click

    expect(page).to have_content('Bolo de cenoura')
    expect(page).to have_content('Bolo de chocolate')
  end
end
