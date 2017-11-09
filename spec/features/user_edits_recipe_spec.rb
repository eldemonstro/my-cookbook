require 'rails_helper'

feature 'user edits recipe' do
  scenario 'successfully' do
    create(:cuisine, name: 'Mexicana')
    create(:recipe_type, name: 'Entrada')
    brasileira = create(:cuisine, name: 'Brasileira')
    sobremesa = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Taco', recipe_type: sobremesa,
                             cuisine: brasileira, difficulty: 'facil',
                             ingredients: 'Pao sirio, molho de cenoura',
                             method: 'Enrolar',
                             cook_time: 15)

    login_as(recipe.user, scope: :user)
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
    mexicana = create(:cuisine, name: 'Mexicana')
    entrada = create(:recipe_type, name: 'Entrada')
    recipe = create(:recipe, title: 'Japaleno', recipe_type: entrada,
                             cuisine: mexicana, difficulty: 'Média',
                             ingredients: 'Pão sírio, carne',
                             method: 'Enrola a carne no pão', cook_time: 20)

    login_as(recipe.user, scope: :user)
    visit edit_recipe_path(recipe)

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and must be logged in' do
    recipe = create(:recipe)

    visit recipe_path recipe

    expect(page).not_to have_link('Editar')
  end

  scenario 'and must be logged in and can\'t have direct access' do
    recipe = create(:recipe)

    visit edit_recipe_path recipe

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and must own the recipe' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    visit recipe_path recipe

    expect(page).not_to have_link('Editar')
  end

  scenario 'and must own the recipe and can\'t have direct access' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user, scope: :user)
    visit edit_recipe_path recipe

    expect(current_path).to eq root_path
  end
end
