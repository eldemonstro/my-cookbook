require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          ingredients: 'Cenoura, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          ingredients: 'Cenoura, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60)

    another_recipe_type = RecipeType.create(name: 'Prato Principal')
    another_recipe = Recipe.create(title: 'Feijoada', recipe_type: another_recipe_type,
                          cuisine: cuisine, difficulty: 'Difícil',
                          ingredients: 'Feijao, paio, carne seca',
                          method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
                          cook_time: 90)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and view last six recipes' do
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipes = []
    recipes << create_recipe('Bolo', recipe_type, cuisine)
    recipes << create_recipe('Brigadeiro', recipe_type, cuisine)
    recipes << create_recipe('Pastel', recipe_type, cuisine)
    recipes << create_recipe('Sorvete', recipe_type, cuisine)
    recipes << create_recipe('Esfirra', recipe_type, cuisine)
    recipes << create_recipe('Coxinha', recipe_type, cuisine)
    recipes << create_recipe('Risole', recipe_type, cuisine)

    visit root_path

    expect(page).not_to have_content(recipes[0].title)
    expect(page).to have_content(recipes[1].title)
    expect(page).to have_content(recipes[2].title)
    expect(page).to have_content(recipes[3].title)
    expect(page).to have_content(recipes[4].title)
    expect(page).to have_content(recipes[5].title)
    expect(page).to have_content(recipes[6].title)
  end
end
