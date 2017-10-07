require 'rails_helper'

feature 'Visitor edits recipe' do
  scenario 'successfully' do
    mexicana = Cuisine.create(name: 'Mexicana')
    brasileira = Cuisine.create(name: 'Brasileira')
    sobremesa = RecipeType.create(name: 'Sobremesa')
    entrada = RecipeType.create(name: 'Entrada')
    recipe = Recipe.create(title: 'Taco', recipe_type: sobremesa,
                          cuisine: brasileira, difficulty: 'facil',
                          ingredients: 'Pao sirio, molho de cenoura',
                          method: 'Enrolar',
                          cook_time: 15)

    visit root_path
    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: 'Taco de carne'
    select 'Mexicana', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Ingredientes', with: 'Pão sirio, molho de tomate, carne'
    fill_in 'Como Preparar', with: 'Enrolar tudo no pão'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Taco de carne')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Mexicana')
    expect(page).to have_css('p', text: 'Pão sirio, molho de tomate, carne')
    expect(page).to have_css('p', text: 'Enrolar tudo no pão')
  end

  scenario 'and leaves a field empty' do
    mexicana = Cuisine.create(name: 'Mexicana')
    entrada = RecipeType.create(name: 'Entrada')
    recipe = Recipe.create(title: 'Japaleno', recipe_type: entrada,
                          cuisine: mexicana, difficulty: 'Média',
                          ingredients: 'Pão sírio, carne',
                          method: 'Enrola a carne no pão', cook_time: 20)

    visit edit_recipe_path(recipe)

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
